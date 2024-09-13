import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pelayanan_laundri/app/modules/tambah_produk/views/tambah_produk_view.dart';
import 'package:pelayanan_laundri/app/modules/transaksi/controllers/transaksi_controller.dart';
import 'package:pelayanan_laundri/utils/constants.dart';
import '../controllers/produk_controller.dart';

class ProdukView extends GetView<ProdukController> {
  const ProdukView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final transaksiController = Get.find<TransaksiController>();

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'List Produk',
            style: TextStyle(
              color: Constants.primaryColor,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
              fontSize: 20,
            ),
          ),
          bottom: TabBar(
            tabs: const [
              Tab(text: 'Kiloan'),
              Tab(text: 'Satuan'),
              Tab(text: 'Parfum'),
            ],
            onTap: (index) {
              switch (index) {
                case 0:
                  controller.filterProdukByCategory('Kiloan');
                  break;
                case 1:
                  controller.filterProdukByCategory('Satuan');
                  break;
                case 2:
                  controller.filterProdukByCategory('Parfum');
                  break;
              }
            },
            labelColor: Constants.primaryColor,
            unselectedLabelColor: Colors.grey[600],
            labelStyle: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              fontFamily: 'Poppins',
            ),
            unselectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                width: 2,
                color: Constants.primaryColor,
              ),
              insets: const EdgeInsets.symmetric(horizontal: 60),
            ),
          ),
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.keyboard_arrow_left_rounded,
              size: 45,
              color: Constants.primaryColor,
            ),
          ),
          centerTitle: true,
        ),
        body: TabBarView(
          children: [
            buildProdukList(transaksiController, 'Kiloan'),
            buildProdukList(transaksiController, 'Satuan'),
            buildProdukList(transaksiController, 'Parfum'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Constants.primaryColor,
          onPressed: () async {
            var result = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const TambahProdukView(),
              ),
            );
            if (result == true) {
              controller.fetchProduk();
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 40,
          ),
        ),
      ),
    );
  }

  Widget buildProdukList(
      TransaksiController transaksiController, String category) {
    return Obx(() {
      var produkList = <Map<String, dynamic>>[];
      bool isLoading = controller.isLoading.value;

      switch (category) {
        case 'Kiloan':
          produkList = controller.filteredKiloanList.toList();
          break;
        case 'Satuan':
          produkList = controller.filteredSatuanList.toList();
          break;
        case 'Parfum':
          produkList = controller.filteredParfumList.toList();
          break;
      }

      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: 'Cari Produk',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      controller.searchProduk(value, category);
                    },
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : produkList.isEmpty
                    ? const Center(
                        child: Text('Tidak ada produk'),
                      )
                    : ListView.builder(
                        itemCount: produkList.length,
                        itemBuilder: (context, index) {
                          var produk = produkList[index];
                          String hargaText;
                          if (produk['harga'] != null &&
                              produk['harga'] is num) {
                            hargaText =
                                'Rp.${(produk['harga'] as num).toStringAsFixed(0)}';
                          } else {
                            hargaText = 'Harga tidak tersedia';
                          }

                          return Card(
                            margin: const EdgeInsets.all(10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              side: const BorderSide(
                                  color: Colors.black, width: 1.5),
                            ),
                            color: Colors.white,
                            child: ListTile(
                              title: Text(
                                produk['nama'] ?? 'Nama tidak tersedia',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              subtitle: category == 'Parfum'
                                  ? null
                                  : Text(
                                      'Harga: $hargaText',
                                    ),
                              trailing: IconButton(
                                icon: const Icon(Icons.delete_outlined),
                                onPressed: () {
                                  controller.deleteProduk(
                                    produk['id'],
                                    category,
                                  );
                                },
                              ),
                              onTap: () {
                                if (category == 'Parfum') {
                                  transaksiController.addParfum(produk);
                                } else {
                                  transaksiController.addProduk(produk);
                                }
                                Get.back();
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      );
    });
  }
}
