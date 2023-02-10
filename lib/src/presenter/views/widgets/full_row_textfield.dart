import 'package:flutter/material.dart';

class FullRowTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Function(String) onSubmitted;
  final OutlineInputBorder? border;

  const FullRowTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.onSubmitted,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    final inputBorder = border ??
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              border: inputBorder,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 1,
                ),
              ),
              enabledBorder: inputBorder,
              filled: true,
              contentPadding: const EdgeInsets.only(
                left: 16,
                right: 8,
                top: 8,
                bottom: 8,
              ),
              fillColor: Theme.of(context).colorScheme.surface,
            ),
            keyboardType: TextInputType.text,
            onSubmitted: (value) {
              if (value.isNotEmpty) {
                onSubmitted(value);
                controller.clear();
              }
            },
            // obscureText: true,
          ),
        ),
      ],
    );
  }
}
