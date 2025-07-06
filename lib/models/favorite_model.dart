class FavoriteModel {
  final int id;
  final int menuId;
  final String createdAt;

  FavoriteModel({
    required this.id,
    required this.menuId,
    required this.createdAt,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: int.parse(json['id'].toString()),
      menuId: int.parse(json['menu_id'].toString()),
      createdAt: json['created_at'] ?? '',
    );
  }
}
