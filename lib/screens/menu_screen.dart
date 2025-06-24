import 'package:flutter/material.dart';
import 'package:project_uas/constants/colors.dart';
import '../widgets/menu_card.dart';
import '../widgets/custom_bottom_nav.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    MenuContent(),
    Center(child: Text('Cart Page', style: TextStyle(fontSize: 20))),
    Center(child: Text('Add Something', style: TextStyle(fontSize: 20))),
    Center(child: Text('History Page', style: TextStyle(fontSize: 20))),
    Center(child: Text('Wishlist Page', style: TextStyle(fontSize: 20))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'MENU',
          style: TextStyle(
            color: textWhite,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        elevation: 0,
      ),
      body: pages[selectedIndex],
    );
  }
}

class MenuContent extends StatelessWidget {
  const MenuContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Search bar
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 48,
          decoration: BoxDecoration(
            color: textWhite,
            borderRadius: BorderRadius.circular(24),
          ),
          child: const Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search......',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Icon(Icons.search),
            ],
          ),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            'Our Menu',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),

        // Grid Menu
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.68, // atur tinggi card
              children: const [
                MenuCard(name: 'Latte', price: '17.000', quantity: 1),
                MenuCard(name: 'Espresso', price: '15.000', quantity: 1),
                MenuCard(name: 'Cappuccino', price: '18.000', quantity: 1),
                MenuCard(name: 'Mocha', price: '19.000', quantity: 1),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
