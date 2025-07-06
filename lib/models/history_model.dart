class HistoryModel {
  final int id;
  final String customerName;
  final String totalPrice;
  final String paymentMethod;
  final String transactionTime;

  HistoryModel({
    required this.id,
    required this.customerName,
    required this.totalPrice,
    required this.paymentMethod,
    required this.transactionTime,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      id: int.parse(json['id'].toString()),
      customerName: json['nama_pelanggan'] ?? '',
      totalPrice: json['total_harga'].toString(),
      paymentMethod: json['metode_pembayaran'] ?? '',
      transactionTime: json['waktu_transaksi'] ?? '',
    );
  }
}
