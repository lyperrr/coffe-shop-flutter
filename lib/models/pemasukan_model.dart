class PemasukanModel {
  final int id;
  final String date;
  final String totalIncome;
  final int totalTransactions;
  final String createdAt;

  PemasukanModel({
    required this.id,
    required this.date,
    required this.totalIncome,
    required this.totalTransactions,
    required this.createdAt,
  });

  factory PemasukanModel.fromJson(Map<String, dynamic> json) {
    return PemasukanModel(
      id: int.parse(json['id'].toString()),
      date: json['tanggal'] ?? '',
      totalIncome: json['total_pemasukan'].toString(),
      totalTransactions: int.parse(json['jumlah_transaksi'].toString()),
      createdAt: json['created_at'] ?? '',
    );
  }
}
