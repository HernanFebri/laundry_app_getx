import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProdukController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<Map<String, dynamic>> kiloanList = RxList<Map<String, dynamic>>([]);
  RxList<Map<String, dynamic>> satuanList = RxList<Map<String, dynamic>>([]);
  RxList<Map<String, dynamic>> parfumList = RxList<Map<String, dynamic>>([]);

  RxList<Map<String, dynamic>> filteredKiloanList =
      RxList<Map<String, dynamic>>([]);
  RxList<Map<String, dynamic>> filteredSatuanList =
      RxList<Map<String, dynamic>>([]);
  RxList<Map<String, dynamic>> filteredParfumList =
      RxList<Map<String, dynamic>>([]);

  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    super.onInit();
    fetchProduk();
  }

  void fetchProduk() async {
    try {
      isLoading.value = true;

      // Fetch Kiloan products
      await firestore.collection('produk').snapshots().listen((snapshot) {
        kiloanList.value = snapshot.docs.map((doc) {
          var data = doc.data();
          data['id'] = doc.id;
          return data;
        }).toList();
        filteredKiloanList.value = kiloanList.toList();
      });

      // Fetch Satuan products
      await firestore
          .collection('produk_satuan')
          .snapshots()
          .listen((snapshot) {
        satuanList.value = snapshot.docs.map((doc) {
          var data = doc.data();
          data['id'] = doc.id;
          return data;
        }).toList();
        filteredSatuanList.value = satuanList.toList();
      });

      // Fetch Parfum products
      await firestore.collection('parfum').snapshots().listen((snapshot) {
        parfumList.value = snapshot.docs.map((doc) {
          var data = doc.data();
          data['id'] = doc.id;
          return data;
        }).toList();
        filteredParfumList.value = parfumList.toList();
      });

      isLoading.value = false;
    } catch (e) {
      Get.snackbar('Error', 'Gagal memuat produk: $e');
      isLoading.value = false;
    }
  }

  void filterProdukByCategory(String category) {
    switch (category) {
      case 'Kiloan':
        filteredKiloanList.value = kiloanList.toList();
        break;
      case 'Satuan':
        filteredSatuanList.value = satuanList.toList();
        break;
      case 'Parfum':
        filteredParfumList.value = parfumList.toList();
        break;
      default:
        Get.snackbar('Error', 'Kategori tidak valid');
    }
  }

  void searchProduk(String query, String category) {
    var lowercaseQuery = query.toLowerCase();
    switch (category) {
      case 'Kiloan':
        filteredKiloanList.value = kiloanList
            .where((produk) => produk['nama']
                .toString()
                .toLowerCase()
                .contains(lowercaseQuery))
            .toList();
        break;
      case 'Satuan':
        filteredSatuanList.value = satuanList
            .where((produk) => produk['nama']
                .toString()
                .toLowerCase()
                .contains(lowercaseQuery))
            .toList();
        break;
      case 'Parfum':
        filteredParfumList.value = parfumList
            .where((produk) => produk['nama']
                .toString()
                .toLowerCase()
                .contains(lowercaseQuery))
            .toList();
        break;
      default:
        Get.snackbar('Error', 'Kategori tidak valid');
    }
  }

  void deleteProduk(String id, String category) async {
    try {
      isLoading.value = true;

      await firestore
          .collection(getCategoryCollection(category))
          .doc(id)
          .delete();
      fetchProduk(); // Refresh produk list after deleting

      Get.snackbar('Success', 'Produk berhasil dihapus');
    } catch (e) {
      Get.snackbar('Error', 'Gagal menghapus produk: $e');
    } finally {
      isLoading.value = false;
    }
  }

  String getCategoryCollection(String category) {
    switch (category) {
      case 'Kiloan':
        return 'produk';
      case 'Satuan':
        return 'produk_satuan';
      case 'Parfum':
        return 'parfum';
      default:
        throw Exception('Kategori tidak valid');
    }
  }
}
