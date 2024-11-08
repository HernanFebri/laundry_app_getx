import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../laporan/controllers/laporan_controller.dart';

class EditTransaksiController extends GetxController {
  TextEditingController paymentMethodController = TextEditingController();
  TextEditingController paymentStatusController = TextEditingController();

  void updateTransaksi() async {
    var laporan = Get.find<LaporanController>().selectedLaporan.value;

    print('Laporan ID: ${laporan['id']}'); // Debugging: Print ID Dokumen

    try {
      await FirebaseFirestore.instance
          .collection('laporanTransaksi')
          .doc(laporan['id'])
          .update({
        'metode_pembayaran': paymentMethodController.text,
        'status_pembayaran': paymentStatusController.text,
      });

      Get.back();
      Get.snackbar('Success',
          'Transaction updated successfully'); // Snackbar for successful update
    } catch (e) {
      print('Error: $e'); // Debugging: Print Error
      Get.snackbar('Error', 'Failed to update transaction');
    }
  }
}
