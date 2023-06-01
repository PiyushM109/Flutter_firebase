import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscure;
  final TextEditingController textController;
  const MyTextField({
    super.key,
    required this.hintText,
    required this.obscure,
    required this.textController,
  });

  @override
  Widget build(BuildContext context) {
    return  TextField(
      obscureText:obscure,
      controller: textController,
      decoration: InputDecoration(
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
        fillColor: Colors.grey[300],
        hintText: hintText,
        filled: true,
      ),
    );
  }
}
