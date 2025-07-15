class HistoryModel {
  final String name;
  final String price;
  final int quantity;
  final String imageBase64;

  HistoryModel({
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageBase64,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
      imageBase64: json['imageBase64'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
      'imageBase64': imageBase64,
    };
  }
}
