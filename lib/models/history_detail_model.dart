class HistoryDetailModel {
  final int id;
  final int historyId;
  final int menuId;
  final int quantity;
  final String subtotal;

  HistoryDetailModel({
    required this.id,
    required this.historyId,
    required this.menuId,
    required this.quantity,
    required this.subtotal,
  });

  factory HistoryDetailModel.fromJson(Map<String, dynamic> json) {
    return HistoryDetailModel(
      id: int.parse(json['id'].toString()),
      historyId: int.parse(json['history_id'].toString()),
      menuId: int.parse(json['menu_id'].toString()),
      quantity: int.parse(json['jumlah'].toString()),
      subtotal: json['subtotal'].toString(),
    );
  }
}
