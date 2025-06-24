import 'package:flutter/material.dart';
import 'package:project_uas/constants/colors.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/order_card.dart';
import '../widgets/order_modal.dart'; // Import the new modal widget

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  int selectedIndex = 0;

  final List<Widget> pages = [
    OrdersContent(),
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
          'ORDERS',
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

class OrdersContent extends StatelessWidget {
  const OrdersContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Order List (Grid)
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: GridView.count(
              crossAxisCount: 1, // Single column for order cards
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5, // Adjust to match card height
              children: [
                OrderCard(name: 'Iced Latte', price: 'Rp. 11.500', quantity: 2),
                // Add more OrderCard widgets as needed
              ],
            ),
          ),
        ),
        // Total Section
        Container(
          padding: const EdgeInsets.all(16.0),
          color: primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Total Orders: 2',
                    style: TextStyle(color: textWhite, fontSize: 16),
                  ),
                  Text(
                    'Total Price: Rp. 23.000',
                    style: TextStyle(color: textWhite, fontSize: 16),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => OrderModal(
                          onOrderPlaced: () {
                            // Add logic here if needed when order is placed
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Order placed!')),
                            );
                          },
                        ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: activeItems,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Order', style: TextStyle(color: textWhite)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
