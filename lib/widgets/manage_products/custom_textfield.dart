import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType? keyboard;
  final String? Function(String?)? validator;
  final int? maxLines;
  final List<TextInputFormatter>? formats;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.labelText,
    this.keyboard,
    this.validator,
    this.maxLines,
    this.formats,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        alignLabelWithHint: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            width: 2.0,
          ),
        ),
      ),
      inputFormatters: formats,
      validator: validator,
      controller: controller,
      keyboardType: keyboard,
      maxLines: maxLines ?? 1,
    );
  }
}
