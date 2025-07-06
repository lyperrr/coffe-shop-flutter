class HistoryItem {
  final int menuId;
  final int jumlah;
  final double subtotal;

  HistoryItem({
    required this.menuId,
    required this.jumlah,
    required this.subtotal,
  });

  Map<String, dynamic> toJson() {
    return {'menu_id': menuId, 'jumlah': jumlah, 'subtotal': subtotal};
  }
}

class HistoryModel {
  final String namaPelanggan;
  final double totalHarga;
  final String metodePembayaran;
  final List<HistoryItem> items;

  HistoryModel({
    required this.namaPelanggan,
    required this.totalHarga,
    required this.metodePembayaran,
    required this.items,
  });

  Map<String, dynamic> toJson() {
    return {
      'nama_pelanggan': namaPelanggan,
      'total_harga': totalHarga,
      'metode_pembayaran': metodePembayaran,
      'items': items.map((e) => e.toJson()).toList(),
    };
  }
}
