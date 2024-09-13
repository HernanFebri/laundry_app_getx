import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pelayanan_laundri/app/modules/laporan/controllers/laporan_controller.dart';
import 'package:pelayanan_laundri/utils/constants.dart';
import '../controllers/edittransaksi_controller.dart';

class EditTransaksiView extends GetView<EditTransaksiController> {
  const EditTransaksiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var laporan = Get.find<LaporanController>().selectedLaporan.value;
    controller.paymentMethodController.text =
        laporan['metode_pembayaran'] ?? '';
    controller.paymentStatusController.text =
        laporan['status_pembayaran'] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Transaksi',
          style: TextStyle(
            fontSize: 20,
            color: Constants.primaryColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.keyboard_arrow_left_rounded,
            size: 50.0,
            color: Constants.primaryColor,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              value: controller.paymentMethodController.text,
              decoration: InputDecoration(
                labelText: 'Metode Pembayaran',
                border: OutlineInputBorder(),
              ),
              items: [
                'Bayar Nanti',
                'Cash',
                'QRIS',
                'Transfer', // Add the new payment method here
              ] // Make sure there are no duplicate values here
                  .map((method) => DropdownMenuItem(
                        value: method,
                        child: Text(method),
                      ))
                  .toList(),
              onChanged: (value) {
                controller.paymentMethodController.text = value!;
              },
            ),
            SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: controller.paymentStatusController.text.isEmpty
                  ? null
                  : controller.paymentStatusController.text,
              decoration: const InputDecoration(
                labelText: 'Status Pembayaran',
                border: const OutlineInputBorder(),
              ),
              items: [
                'Lunas',
                'Belum Lunas',
              ]
                  .map((status) => DropdownMenuItem(
                        value: status,
                        child: Text(status),
                      ))
                  .toList(),
              onChanged: (value) {
                controller.paymentStatusController.text = value!;
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(double.infinity, 45), backgroundColor: Constants.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () {
                controller.updateTransaksi();
              },
              child: Text(
                "Simpan",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Constants.scaffoldbackgroundColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
