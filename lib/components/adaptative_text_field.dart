import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdaptativeTextField extends StatelessWidget {
  const AdaptativeTextField({
    required this.controller,
    required this.label,
    required this.onSubmitted,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],
    super.key,
  });

  final TextEditingController controller;
  final String label;
  final void Function(String) onSubmitted;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: CupertinoTextField(
              controller: controller,
              placeholder: label,
              keyboardType: keyboardType,
              onSubmitted: onSubmitted,
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 12),
            ),
          )
        : TextField(
            controller: controller,
            decoration: InputDecoration(labelText: label),
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            onSubmitted: onSubmitted,
          );
  }
}
