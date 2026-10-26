/// Helper formatting mata uang dan tanggal
class AppFormatters {
  /// Format angka ke Rupiah sederhana (e.g. 50000 -> "Rp 50.000")
  static String formatRupiah(num amount) {
    final value = amount.round().toString();
    final buffer = StringBuffer();
    int count = 0;

    for (int i = value.length - 1; i >= 0; i--) {
      buffer.write(value[i]);
      count++;
      if (count % 3 == 0 && i != 0) {
        buffer.write('.');
      }
    }

    return 'Rp ${buffer.toString().split('').reversed.join('')}';
  }

  /// Format kuantitas dengan satuan (e.g. 50, "Kg" -> "50 Kg")
  static String formatQuantity(num qty, String unit) {
    if (qty == qty.toInt()) {
      return '${qty.toInt()} $unit';
    }
    return '$qty $unit';
  }
}
