import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:okazyon_mobile/core/constants/colors.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.white, 
          elevation: 0, 
          currentIndex: currentIndex,
          onTap: onTap,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          showUnselectedLabels: true,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: [
            _buildNavItem(
              icon: Icon(
                currentIndex == 0 ? Iconsax.home_15 : Iconsax.home,
                color: currentIndex == 0
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
              label: 'Home',
            ),
            _buildNavItem(
              icon: Icon(
                currentIndex == 1 ? Iconsax.category_25 : Iconsax.category,
                color: currentIndex == 1
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
              label: 'Categories',
            ),
            _buildNavItem(
              icon: Icon(
                currentIndex == 2 ? Iconsax.heart5 : Iconsax.heart,
                color: currentIndex == 2
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
              label: 'Favorites',
            ),
            _buildNavItem(
              icon: Icon(
                currentIndex == 3 ? Iconsax.shopping_bag5 : Iconsax.shopping_bag,
                color: currentIndex == 3
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
              label: 'Orders',
            ),
            _buildNavItem(
              icon: Icon(
                currentIndex == 4 ? Iconsax.user_octagon5 : Iconsax.user,
                color: currentIndex == 4
                    ? AppColors.primary
                    : AppColors.textSecondary,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem({
    required Widget icon,
    required String label,
  }) {
    return BottomNavigationBarItem(
      icon: icon,
      label: label,
    );
  }
}
