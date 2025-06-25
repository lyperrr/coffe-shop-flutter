import 'package:flutter/material.dart';
import '../constants/colors.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: textWhite,
      shape: const CircularNotchedRectangle(),
      notchMargin: 6.0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.menu, 'Menu', 0, currentIndex),
          _buildNavItem(Icons.shopping_cart_outlined, 'Cart', 1, currentIndex),
          _buildCenterButton(),
          _buildNavItem(Icons.history, 'History', 3, currentIndex),
          _buildNavItem(Icons.favorite_border, 'Wishlist', 4, currentIndex),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    int index,
    int currentIndex,
  ) {
    final isActive = index == currentIndex;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isActive ? activeItems : anActiveItems),
            Text(
              label,
              style: TextStyle(
                color: isActive ? activeItems : anActiveItems,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterButton() {
    return GestureDetector(
      onTap: () => onTap(2),
      child: Container(
        height: 46,
        width: 46,
        margin: const EdgeInsets.only(top: 4),
        decoration: BoxDecoration(
          color: activeItems,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(Icons.add, color: textWhite),
      ),
    );
  }
}

