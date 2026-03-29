import 'package:flutter/material.dart';

class SyncStatusWidget extends StatelessWidget {
  final bool online;
  final String label;

  const SyncStatusWidget({super.key, required this.online, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: online ? Colors.green.shade100 : Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(online ? Icons.cloud_done : Icons.cloud_off, size: 16, color: online ? Colors.green.shade700 : Colors.grey.shade700),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(color: online ? Colors.green.shade900 : Colors.grey.shade900, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
