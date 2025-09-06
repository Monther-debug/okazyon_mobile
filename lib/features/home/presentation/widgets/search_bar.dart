import 'package:flutter/material.dart';
import 'package:okazyon_mobile/core/constants/colors.dart';
import 'package:okazyon_mobile/core/constants/sizes.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
  return TextField(
      decoration: InputDecoration(
        hintText: 'Search for products or stores...',
        prefixIcon: Padding(
          padding: EdgeInsets.all(AppSizes.defaultSpace * 0.75),
          child:  Icon(Icons.search, color: AppColors.grey),
        ),
        filled: true,
        fillColor: AppColors.lightGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusLg),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
