import 'package:flutter/material.dart';
import 'package:okazyon_mobile/core/constants/colors.dart';
import 'package:okazyon_mobile/core/widgets/custom_button.dart';

class DealOfTheDayCard extends StatelessWidget {
  const DealOfTheDayCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
  padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFFA500),
            Color(0xFFFB923C),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Deal of the Day',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Get 50% off on all winter clothing',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 16),
          CustomButton(
            text: 'Shop Now',
            onPressed: () {

            },
            backgroundColor: Colors.white,
            textColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}
