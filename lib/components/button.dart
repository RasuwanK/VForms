import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    this.fontSize = 12,
  });

  final String text;
  final IconData? icon;
  final EdgeInsets padding;
  final int fontSize;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF4687E1),
        foregroundColor: Colors.white,
        padding: padding,
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(text, style: TextStyle(fontSize: 18)),
          if (icon != null) const SizedBox(width: 10),
          Icon(icon, size: 25),
        ],
      ),
    );
  }
}
