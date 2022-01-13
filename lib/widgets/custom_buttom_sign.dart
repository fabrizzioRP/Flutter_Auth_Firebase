// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class CustomButtomSign extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const CustomButtomSign({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      splashColor: Colors.black,
      color: Colors.purple,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      child: SizedBox(
        height: 50,
        width: 280,
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
