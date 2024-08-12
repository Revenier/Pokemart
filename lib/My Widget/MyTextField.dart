import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final int line;
  final String TextHint;
  final bool secureText;
  final bool unlockText;
  final String? Function(String?)? validator;

  const MyTextField({
    super.key,
    required this.controller,
    required this.TextHint,
    required this.secureText,
    required this.unlockText,
    required this.line,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    EdgeInsetsGeometry contentPadding;
    if (line > 1) {
      contentPadding = EdgeInsets.symmetric(vertical: height * 0.015, horizontal: width * 0.03);
    } else {
      contentPadding = EdgeInsets.symmetric(horizontal: width * 0.03);
    }

    return TextFormField(
      controller: controller,
      obscureText: secureText,
      validator: validator,
      enabled: unlockText,
      maxLines: line,
      decoration: InputDecoration(
        hintText: TextHint,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color.fromARGB(255, 198, 198, 198)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        fillColor: Colors.white,
        filled: true,
        contentPadding: contentPadding,
      ),
    );
  }
}
