import 'package:flutter/material.dart';

class FormInput extends StatefulWidget {
  final String label;
  final bool obscureText;
  final void Function(String) onChanged;

  const FormInput({
    super.key,
    this.label = '',
    this.obscureText = false,
    required this.onChanged,
  });

  @override
  State<FormInput> createState() => _FormInputState();
}

class _FormInputState extends State<FormInput> {
  @override
  Widget build(BuildContext context) {
    final label = widget.label;
    return TextField(
      obscureText: widget.obscureText,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: label,
      ),
    );
  }
}
