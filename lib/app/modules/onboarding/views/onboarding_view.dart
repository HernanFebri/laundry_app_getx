import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pelayanan_laundri/utils/constants.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: SingleChildScrollView(
        child: SizedBox(
          height: Get.height, // Memastikan konten tetap memenuhi layar penuh
          child: Stack(
            alignment: Alignment.center,
            children: [
              Positioned(
                bottom: Get.height *
                    0.4, // Penyesuaian menggunakan persentase layar
                left: 0,
                right: 0,
                top: 0,
                child: Image.asset(
                  "assets/images/logo.png",
                  filterQuality: FilterQuality.high,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                top: 20,
                child: Image.asset(
                  "assets/images/logo2.png",
                  filterQuality: FilterQuality.high,
                ),
              ),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Expanded(
                      flex: 3,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        children: [],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                          vertical: 20.0,
                        ),
                        decoration: BoxDecoration(
                          color: Constants.scaffoldbackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(30.0),
                            topLeft: Radius.circular(30.0),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 10.0),
                            const Text(
                              "Selamat Datang Di Laundri !",
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(height: 10.0),
                            const Text(
                              "Ini adalah versi pertama aplikasi laundry kami, silakan masuk atau buat akun di bawah.",
                              style: TextStyle(
                                color: Color.fromRGBO(74, 77, 84, 1),
                                fontSize: 14.0,
                                fontFamily: 'Poppins',
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    Get.width, 50), // Menggunakan Get.width
                                backgroundColor:
                                    Constants.scaffoldbackgroundColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () {
                                Get.toNamed("/login");
                              },
                              child: Text(
                                "Masuk",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Constants.primaryColor,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                    Get.width, 50), // Menggunakan Get.width
                                backgroundColor: Constants.primaryColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () {
                                Get.toNamed("/register");
                              },
                              child: Text(
                                "Daftar Akun",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Constants.scaffoldbackgroundColor,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
