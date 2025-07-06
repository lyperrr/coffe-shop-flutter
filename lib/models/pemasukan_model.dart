class PemasukanModel {
  final String tanggal;
  final double totalPemasukan;
  final int jumlahTransaksi;

  PemasukanModel({
    required this.tanggal,
    required this.totalPemasukan,
    required this.jumlahTransaksi,
  });

  factory PemasukanModel.fromJson(Map<String, dynamic> json) {
    return PemasukanModel(
      tanggal: json['tanggal'],
      totalPemasukan:
          double.tryParse(json['total_pemasukan'].toString()) ?? 0.0,
      jumlahTransaksi: int.tryParse(json['jumlah_transaksi'].toString()) ?? 0,
    );
  }
}
