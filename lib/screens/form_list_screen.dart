import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/form_provider.dart';
import '../models/monitoring_form_model.dart';
import '../constants/app_colors.dart';

class FormListScreen extends StatefulWidget {
  const FormListScreen({super.key});

  @override
  State<FormListScreen> createState() => _FormListScreenState();
}

class _FormListScreenState extends State<FormListScreen> {
  String _filter = 'All';
  bool _pdfMode = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
      if (args != null && args['pdfMode'] == true) {
        setState(() => _pdfMode = true);
      }
      context.read<FormProvider>().loadSessions();
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<FormProvider>();
    final sessions = _filteredSessions(provider.sessions);

    return Scaffold(
      appBar: AppBar(title: const Text('सहेजे गए फॉर्म')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Wrap(
                  spacing: 8,
                  children: ['All', 'Draft', 'Synced'].map((status) {
                    final selected = _filter == status;
                    return ChoiceChip(
                      label: Text(status),
                      selected: selected,
                      onSelected: (_) => setState(() => _filter = status),
                    );
                  }).toList(),
                ),
                if (_pdfMode) ...[
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.shade50,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text('PDF मोड: किसी सत्र को टैप करें ताकि PDF पूर्वावलोकन देखें', style: TextStyle(color: Colors.black87)),
                  ),
                ],
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: sessions.length,
              itemBuilder: (context, index) {
                final session = sessions[index];
                return Dismissible(
                  key: ValueKey(session.id),
                  direction: session.formStatus == 'draft' ? DismissDirection.endToStart : DismissDirection.none,
                  confirmDismiss: (_) async {
                    return await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Delete Draft'),
                        content: const Text('क्या आप इस ड्राफ्ट फॉर्म को हटाना चाहते हैं?'),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('नहीं')),
                          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('हाँ')),
                        ],
                      ),
                    ) ?? false;
                  },
                  onDismissed: (_) async {
                    await provider.deleteSession(session.id);
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('ड्राफ्ट फॉर्म हटाया गया')));
                  },
                  background: Container(color: Colors.red, alignment: Alignment.centerRight, padding: const EdgeInsets.only(right: 16), child: const Icon(Icons.delete, color: Colors.white)),
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text('${session.district} / ${session.blockName} / ${session.villageWardName}'),
                      subtitle: Text('दिनांक: ${session.monitoringDate} • स्थिति: ${_statusLabel(session)}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(session.synced == 1 ? Icons.cloud_done : Icons.cloud_upload, color: session.synced == 1 ? Colors.green : Colors.orange),
                          const SizedBox(width: 8),
                          IconButton(
                            icon: const Icon(Icons.picture_as_pdf, size: 20),
                            onPressed: () => Navigator.pushNamed(context, '/pdf', arguments: {'sessionId': session.id}),
                          ),
                        ],
                      ),
                      onTap: () {
                        final routeName = _pdfMode ? '/pdf' : '/monitoring';
                        Navigator.pushNamed(context, routeName, arguments: {'sessionId': session.id});
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/monitoring'),
      ),
    );
  }

  List<MonitoringSession> _filteredSessions(List<MonitoringSession> sessions) {
    if (_filter == 'Draft') return sessions.where((s) => s.formStatus == 'draft').toList();
    if (_filter == 'Synced') return sessions.where((s) => s.synced == 1).toList();
    return sessions;
  }

  String _statusLabel(MonitoringSession session) {
    if (session.synced == 1) return 'Synced';
    if (session.formStatus == 'draft') return 'Draft';
    return 'Complete';
  }
}
