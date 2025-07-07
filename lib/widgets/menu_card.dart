import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:project_uas/constants/colors.dart';
import 'package:project_uas/services/api_service.dart';
import '../models/menu_model.dart';
import 'package:provider/provider.dart';
import '../providers/order_provider.dart';
import '../screens/edit_menu_screen.dart';

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

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text("Hapus Menu"),
            content: const Text("Apakah Anda yakin ingin menghapus menu ini?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text("Batal"),
              ),
              TextButton(
                onPressed: () async {
                  Navigator.of(ctx).pop();

                  // Call API delete (Ganti dengan ID asli)
                  final success = await ApiService.deleteMenu(
                    widget.name,
                  ); // Ganti param sesuai API

                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Menu berhasil dihapus")),
                    );

                    // Hapus dari tampilan
                    setState(() => orderQuantity = 0);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Gagal menghapus menu")),
                    );
                  }
                },
                child: const Text("Hapus", style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
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
          // Gambar + tombol favorite dan edit
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
              // Favorite button
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
              // Edit button
              Positioned(
                top: 8,
                left: 8,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => EditMenuScreen(
                              menu: MenuModel(
                                id: 0, // Ganti sesuai data asli jika ada
                                namaMenu: widget.name,
                                kategori: widget.kategori,
                                harga: widget.price,
                                stok: widget.quantity,
                                deskripsi: '', // Bisa diisi jika ada
                                imageBase64: widget.imageBase64,
                              ),
                            ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: textWhite,
                    ),
                    child: const Icon(Icons.edit, size: 20, color: Colors.grey),
                  ),
                ),
              ),

              // Delete button
              Positioned(
                top: 50,
                left: 8,
                child: GestureDetector(
                  onTap: () => _showDeleteDialog(context),
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: textWhite,
                    ),
                    child: const Icon(
                      Icons.delete,
                      size: 20,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ],
          ),

          // Konten menu
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
                // Tombol keranjang
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (orderQuantity > 0) {
                        Provider.of<OrderProvider>(
                          context,
                          listen: false,
                        ).addOrder(
                          OrderItem(
                            name: widget.name,
                            price: widget.price,
                            quantity: orderQuantity,
                            imageBase64: widget.imageBase64,
                          ),
                        );

                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Item ditambahkan ke keranjang'),
                          ),
                        );

                        setState(() => orderQuantity = 0); // reset counter
                      }
                    },
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
