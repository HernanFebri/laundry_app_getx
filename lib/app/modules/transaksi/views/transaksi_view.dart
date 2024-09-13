import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pelayanan_laundri/utils/constants.dart';
import '../controllers/transaksi_controller.dart';
import 'package:pelayanan_laundri/app/modules/produk/views/produk_view.dart';

class TransaksiView extends GetView<TransaksiController> {
  const TransaksiView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.scaffoldbackgroundColor,
        title: Text(
          'Transaksi',
          style: TextStyle(
            color: Constants.primaryColor,
            fontWeight: FontWeight.w600,
            fontFamily: 'Poppins',
            fontSize: 20,
          ),
        ),
        toolbarHeight: 80,
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed('/home');
          },
          icon: Icon(
            Icons.keyboard_arrow_left_rounded,
            size: 45,
            color: Constants.primaryColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.minPositive, 35),
                      backgroundColor: Constants.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed('/pelanggan');
                    },
                    child: Text(
                      "Pelanggan",
                      style: TextStyle(
                        color: Constants.scaffoldbackgroundColor,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.minPositive, 35),
                      backgroundColor: Constants.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Get.to(() => const ProdukView());
                    },
                    child: Text(
                      "Parfum",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Constants.scaffoldbackgroundColor,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.minPositive, 35),
                      backgroundColor: Constants.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () {
                      Get.toNamed('/produk');
                    },
                    child: Text(
                      "Produk",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: Constants.scaffoldbackgroundColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Obx(() {
                    var pelanggan = controller.selectedPelanggan.value;
                    if (pelanggan.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 0,
                            color: Colors.transparent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Nama : ${pelanggan['nama pelanggan']}",
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Nomor : ${pelanggan['nomor WhatsApp']}",
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "Alamat : ${pelanggan['alamat']}",
                                      style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    controller.selectPelanggan({});
                                  },
                                  icon: Icon(
                                    Icons.delete_outlined,
                                    color: Constants.primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(color: Constants.primaryColor),
                        ],
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                  Obx(() {
                    var parfumList = controller.selectedParfum;
                    if (parfumList.isNotEmpty) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                          parfumList.length,
                          (index) {
                            var parfum = parfumList[index];
                            return Column(
                              children: [
                                Card(
                                  elevation: 0,
                                  color: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Parfum: ${parfum['nama']}",
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              controller.removeParfum(index);
                                            },
                                            icon: Icon(
                                              Icons.delete_outlined,
                                              color: Constants.primaryColor,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Divider(color: Constants.primaryColor),
                              ],
                            );
                          },
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }),
                  Obx(
                    () {
                      var produkList = controller.selectedProduk;
                      if (produkList.isNotEmpty) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 5),
                            Card(
                              elevation: 0,
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Nama Produk:",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 5),
                            Card(
                              elevation: 0,
                              color: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  produkList.length,
                                  (index) {
                                    var produk = produkList[index];
                                    return Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "${produk['nama']}\nRp.${produk['harga'].toStringAsFixed(0)}",
                                              style: const TextStyle(
                                                fontFamily: 'Poppins',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 50,
                                                  height: 30,
                                                  child: TextFormField(
                                                    initialValue:
                                                        produk['jumlah'] != null
                                                            ? produk['jumlah']
                                                                .toString()
                                                            : '',
                                                    keyboardType:
                                                        const TextInputType
                                                            .numberWithOptions(
                                                            decimal: true),
                                                    textAlign: TextAlign.center,
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                    ),
                                                    onChanged: (value) {
                                                      if (value.isNotEmpty) {
                                                        controller
                                                            .updateJumlahProduk(
                                                          index,
                                                          double.parse(value)
                                                              .toDouble(),
                                                        );
                                                      } else {
                                                        controller
                                                            .updateJumlahProduk(
                                                          index,
                                                          1,
                                                        );
                                                      }
                                                    },
                                                  ),
                                                ),
                                                IconButton(
                                                  onPressed: () {
                                                    controller
                                                        .removeProduk(index);
                                                  },
                                                  icon: Icon(
                                                    Icons.delete_outlined,
                                                    color:
                                                        Constants.primaryColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Metode Bayar",
                        style: TextStyle(
                          color: Constants.primaryColor,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        value: controller.metodePembayaran.value,
                        onChanged: (newValue) {
                          controller.metodePembayaran.value = newValue!;
                        },
                        items: <String>[
                          'Bayar Nanti',
                          'Cash',
                          'QRIS',
                          'Transfer',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Status Bayar",
                        style: TextStyle(
                          color: Constants.primaryColor,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        value: controller.statusPembayaran.value,
                        onChanged: (newValue) {
                          controller.statusPembayaran.value = newValue!;
                        },
                        items: <String>[
                          'Lunas',
                          'Belum Lunas',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Pengiriman",
                        style: TextStyle(
                          color: Constants.primaryColor,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      DropdownButtonFormField<String>(
                        value: controller.statusPengiriman.value,
                        onChanged: (newValue) {
                          controller.statusPengiriman.value = newValue!;
                        },
                        items: <String>[
                          'Diantar',
                          'Ambil Sendiri',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Obx(() => Text(
                  "Total: Rp.${controller.totalHarga.value.toStringAsFixed(0)}",
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Constants.primaryColor,
                  ),
                )),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
                backgroundColor: Constants.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onPressed: () async {
                controller.saveTransaksi();
              },
              child: Text(
                "Simpan",
                style: TextStyle(
                  color: Constants.scaffoldbackgroundColor,
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
