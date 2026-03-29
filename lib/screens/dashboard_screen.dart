import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/app_colors.dart';
import '../constants/app_strings.dart';
import '../providers/auth_provider.dart';
import '../providers/form_provider.dart';
import '../database/db_helper.dart';
import '../database/sync_service.dart';
import '../services/api_service.dart';
import '../widgets/sync_status_widget.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late final SyncService _syncService;
  bool _isOnline = false;
  String _lastSync = 'Not synced yet';

  @override
  void initState() {
    super.initState();
    _syncService = SyncService(dbHelper: DbHelper.instance, apiService: ApiService(baseUrl: 'http://10.0.2.2'));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<FormProvider>();
      provider.loadSessions();
      _refreshConnectivity();
    });
  }

  Future<void> _refreshConnectivity() async {
    final online = await _syncService.hasInternet();
    setState(() {
      _isOnline = online;
    });
  }

  Future<void> _syncNow() async {
    final result = await _syncService.syncPending();
    if (!mounted) return;
    final message = result['status'] == 'success'
        ? 'Sync completed: ${result['synced_count']} records'
        : result['status'] == 'offline'
            ? 'इंटरनेट उपलब्ध नहीं है'
            : 'Sync failed';
    if (result['status'] == 'success') {
      setState(() => _lastSync = DateTime.now().toLocal().toString());
      await context.read<FormProvider>().loadSessions();
    }
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();
    final formProvider = context.watch<FormProvider>();
    final userName = authProvider.user?.name ?? 'मॉनिटर';

    return Scaffold(
      appBar: AppBar(
        title: const Text('दस्तक मॉनीटरिंग'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sync),
            onPressed: _syncNow,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await authProvider.logout();
              if (!mounted) return;
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await formProvider.loadSessions();
          await _refreshConnectivity();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('स्वागत है, $userName', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text('तारीख: ${DateTime.now().toLocal().toString().substring(0, 10)}', style: const TextStyle(color: Colors.black54)),
              const SizedBox(height: 16),
              SyncStatusWidget(online: _isOnline, label: _isOnline ? 'Online' : 'Offline'),
              const SizedBox(height: 18),
              Row(
                children: [
                  _buildStatCard('Total Forms Saved', formProvider.totalForms.toString()),
                  const SizedBox(width: 12),
                  _buildStatCard('Forms Pending Sync', formProvider.pendingSync.toString()),
                  const SizedBox(width: 12),
                  _buildStatCard('Today\'s Forms', formProvider.todaysForms.toString()),
                ],
              ),
              const SizedBox(height: 24),
              _buildActionButton(startNewMonitoring, Icons.add, () {
                Navigator.pushNamed(context, '/monitoring');
              }),
              const SizedBox(height: 12),
              _buildActionButton(savedForms, Icons.list, () {
                Navigator.pushNamed(context, '/forms');
              }),
              const SizedBox(height: 12),
              _buildActionButton(downloadPdf, Icons.picture_as_pdf, () {
                Navigator.pushNamed(context, '/forms', arguments: {'pdfMode': true});
              }),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(color: Colors.green.shade50, borderRadius: BorderRadius.circular(12)),
                child: Text('Last sync: $_lastSync', style: const TextStyle(color: Colors.black87)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6)]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 14, color: Colors.black54)),
            const SizedBox(height: 12),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(String label, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        decoration: BoxDecoration(color: AppColors.accent, borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            Icon(icon, color: Colors.white),
          ],
        ),
      ),
    );
  }
}
