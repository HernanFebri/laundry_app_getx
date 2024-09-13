import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pelayanan_laundri/utils/constants.dart';

class TambahProdukController extends GetxController {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController hargaController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Field untuk menyimpan kategori yang dipilih
  RxString selectedKategori = RxString('');

  @override
  void onInit() {
    super.onInit();
    selectedKategori.value = 'Kiloan'; // Default kategori
  }

  void tambahProduk(String namaProduk, double harga, String kategori) async {
    if (namaProduk.isEmpty || (kategori != 'Parfum' && harga <= 0)) {
      Get.snackbar('Error', 'Harap lengkapi semua field');
      return;
    }

    try {
      // Menentukan collection berdasarkan kategori
      String collectionName;
      if (kategori == 'Kiloan') {
        collectionName = 'produk';
      } else if (kategori == 'Satuan') {
        collectionName = 'produk_satuan';
      } else if (kategori == 'Parfum') {
        collectionName = 'parfum';
      } else {
        Get.snackbar('Error', 'Kategori tidak valid');
        return;
      }

      await _firestore.collection(collectionName).add({
        'nama': namaProduk,
        if (kategori != 'Parfum') 'harga': harga,
        'kategori': kategori, // Menyimpan kategori ke dalam Firestore
        'created_at': FieldValue.serverTimestamp(),
      });
      Get.snackbar('Success', 'Produk berhasil ditambahkan');
      Get.offNamed('/produk'); // Kembali ke ProdukView setelah simpan

      // Membersihkan input field
      namaController.clear();
      hargaController.clear();
    } catch (e) {
      Get.snackbar('Error', 'Gagal menambahkan produk: $e');
    }
  }
}
