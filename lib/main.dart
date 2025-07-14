import 'package:flutter/material.dart';
import 'package:project_uas/screens/add_menu_screen.dart';
import 'package:project_uas/screens/favorite_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/menu_screen.dart';
import 'screens/order_screen.dart';
import 'constants/colors.dart';
import 'widgets/custom_bottom_nav.dart';
import 'package:provider/provider.dart';
import 'providers/order_provider.dart';
import 'providers/favorite_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OrderProvider()),
        ChangeNotifierProvider(
          create: (_) => FavoriteProvider(),
        ),
      ],
      child: const WelcomeApp(),
    ),
  );
}

class WelcomeApp extends StatelessWidget {
  const WelcomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yesort App',
      theme: ThemeData(
        fontFamily: 'Arial',
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
      ),
      home: const WelcomeScreen(), // Atau ganti langsung ke HomeScreen
    );
  }
}

class HomeScreen extends StatefulWidget {
  final int initialIndex;
  const HomeScreen({super.key, this.initialIndex = 0});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.initialIndex;
  }

  final List<Widget> pages = const [
    MenuScreen(),
    OrdersScreen(),
    AddMenuScreen(),
    Center(child: Text('History Page', style: TextStyle(fontSize: 20))),
    FavoriteScreen(),
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
