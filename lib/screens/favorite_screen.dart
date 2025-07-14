import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project_uas/constants/colors.dart';
import 'package:project_uas/providers/favorite_provider.dart';
import 'package:project_uas/widgets/favorite_card.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favorites = Provider.of<FavoriteProvider>(context).favorites;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: primaryColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0,
        title: const Text(
          'FAVORITE',
          style: TextStyle(
            color: textWhite,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body:
          favorites.isEmpty
              ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite_border, size: 60, color: Colors.grey),
                    SizedBox(height: 12),
                    Text(
                      'Belum ada menu favorit',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ],
                ),
              )
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  final fav = favorites[index];
                  return FavoriteCard(
                    favorite: fav,
                    onDelete: () {
                      Provider.of<FavoriteProvider>(
                        context,
                        listen: false,
                      ).removeFavorite(fav.name);

                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Favorit dihapus')),
                      );
                    },
                  );
                },
              ),
    );
  }
}
