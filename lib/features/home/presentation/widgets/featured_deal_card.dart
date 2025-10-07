import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:okazyon_mobile/core/constants/colors.dart';
import 'package:okazyon_mobile/core/constants/sizes.dart';

class FeaturedDealCard extends StatelessWidget {
  final String image;
  final String title;
  final double price;
  final double originalPrice;
  final double discount;
  final double rating;

  const FeaturedDealCard({
    super.key,
    required this.image,
    required this.title,
    required this.price,
    required this.originalPrice,
    required this.discount,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    final bool isSvg = image.toLowerCase().endsWith('.svg');
    return Container(
      width: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.borderRadiusLg),
                  topRight: Radius.circular(AppSizes.borderRadiusLg),
                ),
                child: SizedBox(
                  height: 120,
                  width: double.infinity,
                  child: isSvg
                      ? SvgPicture.asset(
                          image,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          image,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm),
                  ),
                  child: Text(
                    '-${discount.toInt()}%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.all(AppSizes.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: AppSizes.xs),
                Row(
                  children: [
                    Text(
                      '\$$price',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(width: AppSizes.xs),
                    Text(
                      '\$$originalPrice',
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppSizes.xs),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 16),
                    SizedBox(width: AppSizes.xs),
                    Text(
                      rating.toString(),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
