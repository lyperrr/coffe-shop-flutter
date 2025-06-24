import 'package:flutter/material.dart';
import 'screens/welcome_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/order_screen.dart'; // Import OrdersScreen
import 'screens/auth/register_screen.dart';
import 'constants/colors.dart';
import 'widgets/custom_bottom_nav.dart';

void main() {
  runApp(const MenuApp());
}

class MenuApp extends StatelessWidget {
  const MenuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Welcome',
      theme: ThemeData(
        fontFamily: 'Arial',
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = const [
    MenuScreen(),
    OrdersScreen(),
    Center(child: Text('Add Something', style: TextStyle(fontSize: 20))),
    Center(child: Text('History Page', style: TextStyle(fontSize: 20))),
    Center(child: Text('Wishlist Page', style: TextStyle(fontSize: 20))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: CustomBottomNav(
        currentIndex: selectedIndex,
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}
