import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isOutline;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isOutline = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child:
          isOutline
              ? OutlinedButton(onPressed: onPressed, child: Text(text))
              : ElevatedButton(onPressed: onPressed, child: Text(text)),
    );
  }
}
