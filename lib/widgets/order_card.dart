import 'package:flutter/material.dart';
import 'package:project_uas/constants/colors.dart';

class OrderCard extends StatefulWidget {
  final String name;
  final String price;
  final int quantity;

  const OrderCard({
    super.key,
    required this.name,
    required this.price,
    required this.quantity,
  });

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: textWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          // Checkbox on the left
          Checkbox(
            value: isChecked,
            onChanged: (bool? value) {
              setState(() {
                isChecked = value ?? false;
              });
            },
            activeColor: activeItems,
          ),
          // Placeholder for image
          Container(
            width: 150,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
            ),
            child: const Icon(Icons.image, size: 40, color: Colors.grey),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(widget.price),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text('Qty: '),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: activeItems,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          widget.quantity.toString(),
                          style: const TextStyle(color: textWhite),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
