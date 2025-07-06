import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/menu_model.dart';
import '../models/favorite_model.dart';
import '../models/history_model.dart';
import '../models/history_detail_model.dart';
import '../models/pemasukan_model.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1/project_uas_api';

  // Menu
  static Future<List<MenuModel>> fetchMenus() async {
    final response = await http.get(Uri.parse('$baseUrl/menu/index.php'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => MenuModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load menu');
    }
  }

  // Favorite
  static Future<List<FavoriteModel>> fetchFavorites() async {
    final response = await http.get(Uri.parse('$baseUrl/favorite/index.php'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => FavoriteModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load favorites');
    }
  }

  // History
  static Future<List<HistoryModel>> fetchHistories() async {
    final response = await http.get(Uri.parse('$baseUrl/history/index.php'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => HistoryModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load histories');
    }
  }

  // History Detail
  static Future<List<HistoryDetailModel>> fetchHistoryDetails() async {
    final response = await http.get(
      Uri.parse('$baseUrl/history_detail/index.php'),
    );
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => HistoryDetailModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load history details');
    }
  }

  // Pemasukan Harian
  static Future<List<PemasukanModel>> fetchPemasukanHarian() async {
    final response = await http.get(
      Uri.parse('$baseUrl/pemasukan_harian/index.php'),
    );
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((json) => PemasukanModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load pemasukan harian');
    }
  }
}
