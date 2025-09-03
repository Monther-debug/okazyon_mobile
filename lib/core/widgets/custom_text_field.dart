import 'package:flutter/material.dart';
import 'package:okazyon_mobile/core/constants/app_colors.dart';
import 'package:okazyon_mobile/core/constants/ui_constants.dart';

class CustomTextField extends StatelessWidget {
  // Optional label rendered above the field. If null, no label is shown.
  final String? labelText;
  // Hint text inside the field.
  final String hintText;
  // Obscure input (e.g., for passwords)
  final bool obscureText;
  // Leading icon inside the field
  final IconData? prefixIcon;
  // Trailing icon inside the field
  final IconData? suffixIcon;
  // Action when trailing icon pressed (if provided)
  final VoidCallback? onSuffixIconPressed;
  // Keyboard type for the field
  final TextInputType keyboardType;
  // Validator for form integration
  final FormFieldValidator<String>? validator;
  // Optional controller
  final TextEditingController? controller;

  const CustomTextField({
    super.key,
    this.labelText,
    required this.hintText,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.onSuffixIconPressed,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null && labelText!.isNotEmpty) ...[
          Text(
            labelText!,
            style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.black),
          ),
          const SizedBox(height: 8),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
            suffixIcon: suffixIcon != null
                ? IconButton(
                    icon: Icon(suffixIcon),
                    onPressed: onSuffixIconPressed,
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(UiConstants.borderRadius),
              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.3,)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(UiConstants.borderRadius),
              borderSide: BorderSide(color: AppColors.grey.withOpacity(0.3)),
            ),
          ),
        ),
      ],
    );
  }
}
