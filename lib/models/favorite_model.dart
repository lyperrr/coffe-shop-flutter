class FavoriteModel {
  final int id;
  final int menuId;
  final String namaMenu;

  FavoriteModel({
    required this.id,
    required this.menuId,
    required this.namaMenu,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: int.parse(json['id'].toString()),
      menuId: int.parse(json['menu_id'].toString()),
      namaMenu: json['nama_menu'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'menu_id': menuId};
  }
}
