// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  const CustomTextField({
    Key? key,
    required this.labelText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          label: Text(labelText),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
          suffixIcon: GestureDetector(
            onTap: () {
              controller.clear();
            },
            child: const Icon(Icons.clear),
          )),
    );
  }
}
