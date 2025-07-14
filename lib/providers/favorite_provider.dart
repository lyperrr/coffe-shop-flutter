import 'package:flutter/material.dart';
import '../models/favorite_model.dart';

class FavoriteProvider with ChangeNotifier {
  final List<FavoriteModel> _favorites = [];

  List<FavoriteModel> get favorites => _favorites;

  void addFavorite(FavoriteModel item) {
    if (!_favorites.any((fav) => fav.name == item.name)) {
      _favorites.add(item);
      notifyListeners();
    }
  }

  void removeFavorite(String name) {
    _favorites.removeWhere((item) => item.name == name);
    notifyListeners();
  }

  bool isFavorite(String name) {
    return _favorites.any((item) => item.name == name);
  }
}