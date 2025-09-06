import 'package:flutter/material.dart';
import 'package:okazyon_mobile/core/constants/colors.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  const SectionHeader({
    super.key,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        TextButton(
          onPressed: onPressed,
          child: const Text(
            'View All',
            style: TextStyle(color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}
