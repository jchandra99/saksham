import 'package:flutter/material.dart';

class MultiSelectField extends StatelessWidget {
  final String label;
  final List<String> options;
  final List<String> selectedValues;
  final ValueChanged<List<String>> onChanged;

  const MultiSelectField({super.key, required this.label, required this.options, required this.selectedValues, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ...options.map((option) {
          final checked = selectedValues.contains(option);
          return CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(option),
            value: checked,
            onChanged: (value) {
              final updated = List<String>.from(selectedValues);
              if (value == true) {
                updated.add(option);
              } else {
                updated.remove(option);
              }
              onChanged(updated);
            },
          );
        }).toList(),
      ],
    );
  }
}
