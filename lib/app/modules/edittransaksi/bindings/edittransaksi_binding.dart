import 'package:get/get.dart';

import '../controllers/edittransaksi_controller.dart';

class EditTransaksiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditTransaksiController>(
      () => EditTransaksiController(),
    );
  }
}
