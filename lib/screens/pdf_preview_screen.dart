import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:printing/printing.dart';
import '../providers/form_provider.dart';
import '../services/pdf_service.dart';
import '../models/monitoring_form_model.dart';

class PdfPreviewScreen extends StatefulWidget {
  final String sessionId;

  const PdfPreviewScreen({super.key, required this.sessionId});

  @override
  State<PdfPreviewScreen> createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen> {
  late Future<void> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture = _ensureSessionLoaded();
  }

  Future<void> _ensureSessionLoaded() async {
    final provider = context.read<FormProvider>();
    if (provider.selectedSession?.id != widget.sessionId) {
      await provider.selectSession(widget.sessionId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: FutureBuilder<void>(
        future: _loadFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }

          final provider = context.watch<FormProvider>();
          final session = provider.selectedSession;
          final houses = provider.houses;

          if (session == null) {
            return const Center(child: Text('Session not found'));
          }

          return PdfPreview(
            build: (format) => PdfService.generateReport(session: session, houses: houses),
            allowPrinting: true,
            allowSharing: true,
            canChangeOrientation: false,
            canChangePageFormat: true,
            initialPageFormat: PdfPageFormat.a4,
          );
        },
      ),
    );
  }
}
