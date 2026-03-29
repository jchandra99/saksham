import 'package:flutter/material.dart';

class YesNoField extends StatelessWidget {
  final String label;
  final String value;
  final ValueChanged<String> onChanged;

  const YesNoField({super.key, required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Row(
          children: ['हाँ', 'नहीं'].map((option) {
            final selected = option == value;
            return Expanded(
              child: GestureDetector(
                onTap: () => onChanged(option),
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: selected ? Colors.green : Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                    color: selected ? Colors.green.shade50 : Colors.white,
                  ),
                  child: Center(child: Text(option, style: TextStyle(color: selected ? Colors.green.shade900 : Colors.black))),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
