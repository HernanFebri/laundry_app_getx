import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class TransaksiController extends GetxController {
  var selectedPelanggan = {}.obs;
  var selectedParfum = <Map<String, dynamic>>[].obs;
  var selectedProduk = <Map<String, dynamic>>[].obs;
  var metodePembayaran = 'Cash'.obs;
  var statusPembayaran = 'Lunas'.obs;
  var statusPengiriman = 'Diantar'.obs;
  var totalHarga = 0.0.obs;

  void selectPelanggan(Map<String, dynamic> pelanggan) {
    selectedPelanggan.value = pelanggan;
  }

  void addParfum(Map<String, dynamic> parfum) {
    selectedParfum.add(parfum);
  }

  void removeParfum(int index) {
    selectedParfum.removeAt(index);
  }

  void addProduk(Map<String, dynamic> produk) {
    selectedProduk.add(produk);
  }

// Select and remove produk and update jumlah produk
  void selectProduk(Map<String, dynamic> produk) {
    produk['jumlah'] = 0.0; // Default jumlah produk adalah 1
    selectedProduk.add(produk);
    _hitungTotalHarga();
  }

  void removeProduk(int index) {
    selectedProduk.removeAt(index);
    _hitungTotalHarga();
  }

  void updateJumlahProduk(int index, double jumlah) {
    selectedProduk[index]['jumlah'] = jumlah;
    _hitungTotalHarga();
  }

// Hitung total harga
  void _hitungTotalHarga() {
    double total = 0;
    for (var produk in selectedProduk) {
      double harga = produk['harga'] != null && produk['harga'] is num
          ? (produk['harga'] as num).toDouble()
          : 0.0;
      double jumlah = produk['jumlah'] != null && produk['jumlah'] is num
          ? (produk['jumlah'] as num).toDouble()
          : 0.0;
      total += harga * jumlah;
    }
    totalHarga.value = total;
  }

  Future<void> saveTransaksi() async {
    try {
      var transaksiData = {
        'pelanggan': selectedPelanggan.value,
        'parfum': selectedParfum.map((e) => e['nama']).toList(),
        'produk': selectedProduk
            .map((e) => {
                  'nama': e['nama'],
                  'harga': e['harga'],
                  'jumlah': e['jumlah'],
                })
            .toList(),
        'metode_pembayaran': metodePembayaran.value,
        'status_pembayaran': statusPembayaran.value,
        'status_pengiriman': statusPengiriman.value,
        'totalHarga': totalHarga.value,
        'tanggal': Timestamp.now(),
      };

      await FirebaseFirestore.instance
          .collection('laporanTransaksi')
          .add(transaksiData);
      Get.snackbar('Success', 'Transaksi berhasil disimpan');
      clearSelections();
    } catch (e) {
      throw Exception('Failed to save transaction: $e');
    }
  }

  void clearSelections() {
    selectedPelanggan.value = {};
    selectedParfum.clear();
    selectedProduk.clear();
    metodePembayaran.value = 'Cash';
    statusPembayaran.value = 'Lunas';
    statusPengiriman.value = 'Diantar';
    totalHarga.value = 0;
    totalHarga.refresh();
  }
}
