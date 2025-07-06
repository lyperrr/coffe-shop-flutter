class MenuModel {
  final int? id;
  final String namaMenu;
  final String kategori;
  final String harga;
  final int stok;
  final String deskripsi;
  final String imageBase64;

  MenuModel({
    this.id,
    required this.namaMenu,
    required this.kategori,
    required this.harga,
    required this.stok,
    required this.deskripsi,
    required this.imageBase64,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      id: int.tryParse(json['id'].toString()),
      namaMenu: json['nama_menu'] ?? '',
      kategori: json['kategori'] ?? '',
      harga: json['harga'].toString(),
      stok: int.tryParse(json['stok'].toString()) ?? 0,
      deskripsi: json['deskripsi'] ?? '',
      imageBase64: json['gambar'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nama_menu': namaMenu,
      'kategori': kategori,
      'harga': harga,
      'stok': stok,
      'deskripsi': deskripsi,
      'gambar': imageBase64,
    };
  }
}
