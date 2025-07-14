import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/menu_model.dart';
import '../models/favorite_model.dart';
import '../models/history_model.dart';
import '../models/pemasukan_model.dart';

class ApiService {
  //Ganti IP jika pakai device fisik (bukan emulator)
  static const String _baseUrl = 'http://127.0.0.1/project_uas_api';

  //MENU
  static Future<List<MenuModel>> fetchMenus() async {
    final response = await http.get(Uri.parse('$_baseUrl/menu/index.php'));

    print("Status Code: ${response.statusCode}");
    print("Body: ${response.body}");

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List menus = data['data'];
      return menus.map((e) => MenuModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil data menu');
    }
  }

  static Future<bool> addMenu(MenuModel menu) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/menu/store.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(menu.toJson()),
    );
    return jsonDecode(response.body)['status'];
  }

  static Future<bool> updateMenu(MenuModel menu) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/menu/update.php'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(menu.toJson()),
      );

      print("BODY SENT: ${jsonEncode(menu.toJson())}");
      print("STATUS CODE: ${response.statusCode}");
      print("RESPONSE BODY: ${response.body}");

      final data = jsonDecode(response.body);
      return data['status'];
    } catch (e) {
      print("ERROR UPDATE MENU: $e");
      return false;
    }
  }

static Future<bool> deleteMenu(int id) async {
    try {
      final res = await http.post(
        Uri.parse('$_baseUrl/menu/delete.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'id': id}),
      );
      final data = jsonDecode(res.body);
      return data['status'] == true;
    } catch (e) {
      print('Delete Error: $e');
      return false;
    }
  }


  //FAVORITE
  static Future<List<FavoriteModel>> fetchFavorites() async {
    final response = await http.get(Uri.parse('$_baseUrl/favorite/index.php'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List favs = data['data'];
      return favs.map((e) => FavoriteModel.fromJson(e)).toList();
    } else {
      throw Exception('Gagal mengambil data favorite');
    }
  }

  static Future<bool> addFavorite(int menuId) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/favorite/store.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"menu_id": menuId}),
    );
    return jsonDecode(response.body)['status'];
  }

  static Future<bool> deleteFavorite(int id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/favorite/delete.php?id=$id'),
    );
    return jsonDecode(response.body)['status'];
  }

  //HISTORY (TRANSAKSI)
  static Future<bool> submitTransaction(HistoryModel history) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/history/store.php'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(history.toJson()),
    );
    return jsonDecode(response.body)['status'];
  }

  //PEMASUKAN HARIAN
  static Future<PemasukanModel?> fetchPemasukanHarian() async {
    final response = await http.get(Uri.parse('$_baseUrl/pemasukan/daily.php'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return PemasukanModel.fromJson(data['data']);
    } else {
      return null;
    }
  }
}
