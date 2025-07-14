class FavoriteModel {
  final String name;
  final String price;
  final String kategori;
  final String imageBase64;

  FavoriteModel({
    required this.name,
    required this.price,
    required this.kategori,
    required this.imageBase64,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      name: json['name'],
      price: json['price'],
      kategori: json['kategori'],
      imageBase64: json['imageBase64'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'kategori': kategori,
      'imageBase64': imageBase64,
    };
  }
}