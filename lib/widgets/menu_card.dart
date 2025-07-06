import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_uas/constants/colors.dart';

class MenuCard extends StatelessWidget {
  final String name;
  final String price;
  final int quantity;
  final String imageBase64;

  const MenuCard({
    super.key,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageBase64,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: textWhite,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar + Favorite Icon
          Stack(
            children: [
              Container(
                height: 120,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  color: Colors.grey[300],
                ),
                child:
                    imageBase64.isNotEmpty
                        ? ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          child: Image.memory(
                            base64Decode(imageBase64),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: 120,
                          ),
                        )
                        : const Icon(
                          Icons.image,
                          size: 40,
                          color: anActiveItems,
                        ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: textWhite,
                  ),
                  child: const Icon(
                    Icons.favorite,
                    size: 20,
                    color: anActiveItems,
                  ),
                ),
              ),
            ],
          ),

          // Informasi Menu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Chip(
                  label: Text("Iced", style: TextStyle(fontSize: 14)),
                  backgroundColor: backgroundColor,
                  padding: EdgeInsets.symmetric(horizontal: 2),
                  visualDensity: VisualDensity.compact,
                ),
                const SizedBox(height: 5),
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text('Rp. $price', style: const TextStyle(fontSize: 12)),
                const SizedBox(height: 12),

                // Qty dan tombol keranjang
                Row(
                  children: [
                    _circleButton(Icons.add),
                    const SizedBox(width: 8),
                    Text(
                      '$quantity',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    _circleButton(Icons.remove),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: activeItems,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: const Icon(
                        Icons.shopping_cart_outlined,
                        size: 18,
                        color: textWhite,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      height: 25,
      width: 25,
      decoration: const BoxDecoration(
        color: activeItems,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, size: 14, color: textWhite),
    );
  }
}
