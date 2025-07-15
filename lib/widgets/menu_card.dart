import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_uas/constants/colors.dart';
import 'package:project_uas/services/api_service.dart';
import '../models/menu_model.dart';
import '../models/favorite_model.dart';
import '../models/history_model.dart';
import '../providers/order_provider.dart';
import '../providers/favorite_provider.dart';
import '../providers/history_provider.dart';
import '../screens/edit_menu_screen.dart';

class MenuCard extends StatefulWidget {
  final int id;
  final String name;
  final String price;
  final String kategori;
  final int quantity;
  final String imageBase64;
  final VoidCallback onDeleted;

  const MenuCard({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.kategori,
    required this.quantity,
    required this.imageBase64,
    required this.onDeleted,
  });

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  int orderQuantity = 0;

  void _increaseQuantity() {
    if (orderQuantity < widget.quantity) {
      setState(() => orderQuantity++);
    }
  }

  void _decreaseQuantity() {
    if (orderQuantity > 0) {
      setState(() => orderQuantity--);
    }
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
                  final success = await ApiService.deleteMenu(widget.id);
                  if (success) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Menu berhasil dihapus")),
                    );
                    widget.onDeleted();
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

  @override
  Widget build(BuildContext context) {
    final favoriteProvider = Provider.of<FavoriteProvider>(context);
    final isFav = favoriteProvider.isFavorite(widget.name);

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
          Stack(
            children: [
              // Gambar
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
                        : const Icon(Icons.image, size: 40, color: Colors.grey),
              ),

              // Tombol Favorite
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () {
                    if (isFav) {
                      favoriteProvider.removeFavorite(widget.name);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Dihapus dari favorit')),
                      );
                    } else {
                      favoriteProvider.addFavorite(
                        FavoriteModel(
                          name: widget.name,
                          price: widget.price,
                          kategori: widget.kategori,
                          imageBase64: widget.imageBase64,
                        ),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Ditambahkan ke favorit')),
                      );
                    }
                    setState(() {});
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(
                      isFav ? Icons.favorite : Icons.favorite_border,
                      size: 20,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),

              // Tombol Edit
              Positioned(
                top: 8,
                left: 8,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => EditMenuScreen(
                              menu: MenuModel(
                                id: widget.id,
                                namaMenu: widget.name,
                                kategori: widget.kategori,
                                harga: widget.price,
                                stok: widget.quantity,
                                deskripsi: '',
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

              // Tombol Delete
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

          // Detail Menu
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Chip(
                  label: Text(
                    widget.kategori,
                    style: const TextStyle(fontSize: 12),
                  ),
                  backgroundColor: backgroundColor,
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

                // Counter
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

                // Tombol Keranjang
                Center(
                  child: GestureDetector(
                    onTap: () {
                      if (orderQuantity > 0) {
                        // Tambah ke keranjang
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

                        // Tambah ke history
                        Provider.of<HistoryProvider>(
                          context,
                          listen: false,
                        ).addToHistory(
                          HistoryModel(
                            name: widget.name,
                            price: widget.price,
                            quantity: orderQuantity,
                            imageBase64: widget.imageBase64,
                          ),
                        );

                        // Feedback
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Item ditambahkan ke keranjang & history',
                            ),
                          ),
                        );

                        setState(() => orderQuantity = 0);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: activeItems,
                        borderRadius: BorderRadius.circular(8),
                      ),
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
