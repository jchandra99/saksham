import 'package:flutter/material.dart';

class YesNoNAField extends StatelessWidget {
  final String label;
  final String value;
  final ValueChanged<String> onChanged;

  const YesNoNAField({super.key, required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    final options = ['हाँ', 'नहीं', 'लागू नहीं'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: options.map((option) {
            final selected = option == value;
            return ChoiceChip(
              label: Text(option),
              selected: selected,
              onSelected: (_) => onChanged(option),
            );
          }).toList(),
        ),
      ],
    );
  }
}
