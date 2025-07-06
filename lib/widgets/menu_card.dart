import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_uas/constants/colors.dart';

class MenuCard extends StatefulWidget {
  final String name;
  final String price;
  final String kategori;
  final int quantity;
  final String imageBase64;

  const MenuCard({
    super.key,
    required this.name,
    required this.price,
    required this.kategori,
    required this.quantity,
    required this.imageBase64,
  });

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  int orderQuantity = 0;

  void _increaseQuantity() {
    setState(() {
      if (orderQuantity < widget.quantity) {
        orderQuantity++;
      }
    });
  }

  void _decreaseQuantity() {
    setState(() {
      if (orderQuantity > 0) {
        orderQuantity--;
      }
    });
  }

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
          // Gambar
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
                    widget.imageBase64.isNotEmpty
                        ? ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          child: Image.memory(
                            base64Decode(widget.imageBase64),
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

          // Konten
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(
                  label: Text(
                    widget.kategori.isNotEmpty ? widget.kategori : 'Kategori',
                    style: const TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                  backgroundColor: backgroundColor,
                  padding: const EdgeInsets.symmetric(horizontal: 1),
                  visualDensity: VisualDensity.compact,
                ),
                const SizedBox(height: 5),
                Text(
                  widget.name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Rp. ${widget.price}',
                  style: const TextStyle(fontSize: 12),
                ),
                const SizedBox(height: 2),
                Text(
                  'Stok: ${widget.quantity}',
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
                const SizedBox(height: 8),

                // Counter +/-
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _circleButton(Icons.remove, _decreaseQuantity),
                    const SizedBox(width: 8),
                    Text(
                      '$orderQuantity',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 8),
                    _circleButton(Icons.add, _increaseQuantity),
                  ],
                ),

                const SizedBox(height: 10),

                // Tombol keranjang
                Center(
                  child: Container(
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 25,
        width: 25,
        decoration: const BoxDecoration(
          color: activeItems,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 14, color: textWhite),
      ),
    );
  }
}
