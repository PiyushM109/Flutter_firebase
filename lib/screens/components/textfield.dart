import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final bool obscure;
  const MyTextField({
    super.key,
    required this.hintText,
    required this.obscure,
  });

  @override
  Widget build(BuildContext context) {
    return  TextField(
      obscureText:obscure,
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
