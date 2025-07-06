class HistoryDetailModel {
  final int id;
  final int historyId;
  final int menuId;
  final int jumlah;
  final double subtotal;

  HistoryDetailModel({
    required this.id,
    required this.historyId,
    required this.menuId,
    required this.jumlah,
    required this.subtotal,
  });

  factory HistoryDetailModel.fromJson(Map<String, dynamic> json) {
    return HistoryDetailModel(
      id: int.parse(json['id'].toString()),
      historyId: int.parse(json['history_id'].toString()),
      menuId: int.parse(json['menu_id'].toString()),
      jumlah: int.parse(json['jumlah'].toString()),
      subtotal: double.tryParse(json['subtotal'].toString()) ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'history_id': historyId,
      'menu_id': menuId,
      'jumlah': jumlah,
      'subtotal': subtotal,
    };
  }
}
