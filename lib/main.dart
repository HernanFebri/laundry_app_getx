import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app/modules/detailorder/controllers/detailorder_controller.dart';
import 'app/modules/edittransaksi/controllers/edittransaksi_controller.dart';
import 'app/modules/laporan/controllers/laporan_controller.dart';
import 'app/modules/pelanggan/controllers/pelanggan_controller.dart';
import 'app/modules/produk/controllers/produk_controller.dart';
import 'app/modules/profile/controllers/profile_controller.dart';
import 'app/modules/tambah_pelanggan/controllers/tambah_pelanggan_controller.dart';
import 'app/modules/tambah_produk/controllers/tambah_produk_controller.dart';
import 'app/modules/transaksi/controllers/transaksi_controller.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyBTxIxrXum3_GXO2yvzrLB9FT2ds_IIkM4",
      appId: "1:784242798005:android:7cc0883a2f2102ac9cfdfc",
      messagingSenderId: "784242798005",
      projectId: "laundry-fc799",
      storageBucket: "laundry-fc799.appspot.com",
    ),
  );

  Get.put(PelangganController());
  Get.put(TambahProdukController());
  Get.put(ProdukController());
  Get.put(TambahPelangganController());
  Get.put(TransaksiController());
  Get.put(DetailorderController());
  Get.put(ProfileController());
  Get.put(EditTransaksiController());
  Get.put(LaporanController());

// Determine initial route based on login status
  String initialRoute = FirebaseAuth.instance.currentUser != null
      ? Routes.HOME
      : AppPages.INITIAL;

  runApp(
    ScreenUtilInit(
      designSize: const Size(450, 975),
      builder: (_, __) => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Application",
        initialRoute: initialRoute,
        getPages: AppPages.routes,
        theme: ThemeData(),
      ),
    ),
  );
}
