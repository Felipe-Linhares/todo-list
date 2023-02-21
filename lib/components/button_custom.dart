import 'package:flutter/material.dart';

class ButtonCustom extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  const ButtonCustom(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: color,
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
