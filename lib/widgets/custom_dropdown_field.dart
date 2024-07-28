import 'package:flutter/material.dart';

class CustomDropdownField extends StatelessWidget {
  final String hintText;
  final List<String> options;
  final ValueChanged<String?> onChanged;
  final String? value;
  final String? labelText;

  CustomDropdownField(
      {required this.hintText,
      required this.options,
      required this.onChanged,
      this.value,
      this.labelText});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
        ),
        hint: Text(hintText),
        value: value,
        items: options.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }
}
