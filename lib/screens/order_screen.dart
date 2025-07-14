import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_uas/constants/colors.dart';
import '../providers/order_provider.dart';
import '../widgets/order_card.dart';
import '../widgets/order_modal.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

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
      body: const OrdersContent(),
    );
  }
}

class OrdersContent extends StatefulWidget {
  const OrdersContent({super.key});

  @override
  State<OrdersContent> createState() => _OrdersContentState();
}

class _OrdersContentState extends State<OrdersContent> {
  final List<String> selectedOrderNames = [];

  @override
  Widget build(BuildContext context) {
    final orders = Provider.of<OrderProvider>(context).orders;
    final selectedOrders =
        orders
            .where((order) => selectedOrderNames.contains(order.name))
            .toList();

    int totalQuantity = selectedOrders.fold(
      0,
      (sum, item) => sum + item.quantity,
    );

    int totalPrice = selectedOrders.fold(0, (sum, item) {
      final cleanPrice =
          int.tryParse(item.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      return sum + (cleanPrice * item.quantity);
    });

    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                orders.isEmpty
                    ? const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.shopping_bag_outlined,
                            size: 60,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 12),
                          Text(
                            'Belum ada pesanan',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ],
                      ),
                    )
                    : ListView(
                      children:
                          orders.map((order) {
                            return OrderCard(
                              name: order.name,
                              price: order.price,
                              quantity: order.quantity,
                              imageBase64: order.imageBase64 ?? '',
                              isSelected: selectedOrderNames.contains(
                                order.name,
                              ),
                              onSelected: (selected) {
                                setState(() {
                                  if (selected) {
                                    selectedOrderNames.add(order.name);
                                  } else {
                                    selectedOrderNames.remove(order.name);
                                  }
                                });
                              },
                            );
                          }).toList(),
                    ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(16.0),
          color: primaryColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Orders: $totalQuantity',
                    style: const TextStyle(color: textWhite, fontSize: 16),
                  ),
                  Text(
                    'Total Price: Rp. $totalPrice',
                    style: const TextStyle(color: textWhite, fontSize: 16),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed:
                    selectedOrders.isNotEmpty
                        ? () {
                          showDialog(
                            context: context,
                            builder:
                                (context) => OrderModal(
                                  onOrderPlaced: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Order placed!'),
                                      ),
                                    );

                                    setState(() {
                                      selectedOrderNames.clear();
                                    });

                                    // Optional: hapus order dari daftar
                                    // for (var item in selectedOrders) {
                                    //   Provider.of<OrderProvider>(context, listen: false)
                                    //       .removeOrderByName(item.name);
                                    // }
                                  },
                                ),
                          );
                        }
                        : null,
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
