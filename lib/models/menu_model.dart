class MenuModel {
  final int id;
  final String name;
  final String category;
  final String price;
  final int stock;
  final String description;
  final String imageBase64;
  final String createdAt;
  final String updatedAt;
  final int quantity;

  MenuModel({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    required this.description,
    required this.imageBase64,
    required this.createdAt,
    required this.updatedAt,
    this.quantity = 0,
  });

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      id: int.parse(json['id'].toString()),
      name: json['nama_menu'] ?? '',
      category: json['kategori'] ?? '',
      price: json['harga'].toString(),
      stock: int.parse(json['stok'].toString()),
      description: json['deskripsi'] ?? '',
      imageBase64: json['gambar'] ?? '',
      createdAt: json['created_at'] ?? '',
      updatedAt: json['updated_at'] ?? '',
      quantity: 0,
    );
  }
}
