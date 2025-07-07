import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_uas/constants/colors.dart';

class OrderCard extends StatelessWidget {
  final String name;
  final String price;
  final int quantity;
  final String imageBase64;
  final bool isSelected;
  final ValueChanged<bool> onSelected;

  const OrderCard({
    super.key,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageBase64,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onSelected(!isSelected),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: textWhite,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade300,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Checkbox(
                value: isSelected,
                onChanged: (value) => onSelected(value!),
                activeColor: activeItems,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child:
                  imageBase64.isNotEmpty
                      ? Image.memory(
                        base64Decode(imageBase64),
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                      : Container(
                        width: 100,
                        height: 100,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image, color: Colors.grey),
                      ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text('Harga: Rp. $price'),
                    const SizedBox(height: 4),
                    Text('Jumlah: $quantity'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
