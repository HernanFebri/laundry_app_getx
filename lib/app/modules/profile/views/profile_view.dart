import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:pelayanan_laundri/utils/constants.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile Saya',
          style: TextStyle(
            color: Constants.primaryColor,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.offAllNamed('/home');
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Constants.primaryColor,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Obx(
                  () => CircleAvatar(
                    radius: 70,
                    child: controller.imagePath.value.isNotEmpty
                        ? ClipOval(
                            child: Image.network(
                              controller.imagePath.value,
                              fit: BoxFit.cover,
                              width: 140,
                              height: 140,
                            ),
                          )
                        : SvgPicture.asset(
                            "assets/images/person.svg",
                            fit: BoxFit.cover,
                            width: 140,
                            height: 140,
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => Text(
                  controller.name.value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Obx(
                () => Text(
                  controller.email.value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Umum",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey,
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              child: Wrap(
                                children: [
                                  ListTile(
                                    leading: SvgPicture.asset(
                                        "assets/images/editprofile.svg"),
                                    title: Text(
                                      'Edit Profil',
                                      style: TextStyle(
                                        color: Constants.primaryColor,
                                      ),
                                    ),
                                    onTap: () {
                                      Get.back();
                                      controller.showEditNameDialog(context);
                                    },
                                  ),
                                  ListTile(
                                    leading: SvgPicture.asset(
                                        "assets/images/ubahfoto.svg"),
                                    title: Text(
                                      'Ubah Foto Profile',
                                      style: TextStyle(
                                        color: Constants.primaryColor,
                                      ),
                                    ),
                                    onTap: () {
                                      Get.back();
                                      controller.pickImage();
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/images/person.svg"),
                          const SizedBox(width: 20),
                          const Text(
                            "Ubah Profil",
                            style: TextStyle(color: Colors.black),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (BuildContext context) {
                            return SingleChildScrollView(
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          "Tentang Kami",
                                          style: TextStyle(
                                            fontSize: 30,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Get.back();
                                          },
                                          child: SvgPicture.asset(
                                            "assets/images/x.svg",
                                            height: 25,
                                            width: 25,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    const Text(
                                      "Selamat datang di Purple Clean Laundry, Aplikasi kasir laundry yang dirancang untuk mempermudah pengelolaan bisnis laundry. Aplikasi ini diciptakan khusus untuk membantu kasir dan pemilik akun dalam mengelola operasional sehari-hari dengan lebih efisien dan efektif.\n\nDengan Purple Clean Laundry,penginputan data produk,parfum, serta transaksi menjadi lebih mudah dan terorganisir. Oleh karena itu aplikasi ini hadir untuk memenuhi kebutuhan tersebut,aplikasi ini dapat menyimpan nota gambar dan bisa langsung chat via Whatsapp pelanggan.\n\nPembuatan Aplikasi Purple Clean Laundry : Hernan Febri Rahmatullah dengan NIM 20SA1173\nPerancangan Desain Aplikasi Purple Clean Laundry : Satria Bagus Prasetya dengan NIM 20SA1221",
                                      style: TextStyle(
                                        fontSize: 16,
                                      ),
                                      textAlign: TextAlign.justify,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/images/tentangkami.svg"),
                          const SizedBox(width: 20),
                          const Text(
                            "Tentang Kami",
                            style: TextStyle(color: Colors.black),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Constants.fourColor,
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      onPressed: () {
                        controller.showLogoutConfirmationDialog(context);
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset("assets/images/logout.svg"),
                          const SizedBox(width: 20),
                          const Text(
                            "Logout",
                            style: TextStyle(color: Colors.white),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 20,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
