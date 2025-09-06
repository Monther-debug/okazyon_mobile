import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isOutline;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutline = false,
  this.backgroundColor,
  this.textColor,
  });

  @override
  Widget build(BuildContext context) {
  final txtStyle = textColor != null
    ? TextStyle(color: textColor, fontWeight: FontWeight.w600)
    : const TextStyle(fontWeight: FontWeight.w600);

  final child = Text(text, style: txtStyle);

  return SizedBox(
    width: double.infinity,
    child: isOutline
      ? OutlinedButton(onPressed: onPressed, child: child)
      : ElevatedButton(
        style: backgroundColor != null
          ? ElevatedButton.styleFrom(backgroundColor: backgroundColor)
          : null,
        onPressed: onPressed,
        child: child,
      ),
  );
  }
}
