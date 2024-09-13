import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pelayanan_laundri/utils/constants.dart';

import '../controllers/lupa_password_controller.dart';

class LupaPasswordView extends GetView<LupaPasswordController> {
  const LupaPasswordView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: SafeArea(
        bottom: false,
        child: Container(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Positioned(
                right: 0.0,
                top: -20.0,
                child: Opacity(
                  opacity: 0.3,
                  child: Image.asset("assets/images/mesin.png"),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 15.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.keyboard_arrow_left_rounded,
                            size: 45,
                            color: Constants.scaffoldbackgroundColor,
                          ),
                        ),
                        const Center(
                          child: Column(
                            children: [
                              Text(
                                "LUPA",
                                style: TextStyle(
                                    fontSize: 40.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'FontPuppins'),
                              ),
                              Text(
                                "PASSWORD",
                                style: TextStyle(
                                    fontSize: 40.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w900,
                                    fontFamily: 'FontPuppins'),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                "Laundree! sudah menantikan kamu, ayo mulai laporkan keadaan terkini.",
                                style: TextStyle(
                                    fontSize: 14.0,
                                    color: Colors.white,
                                    fontFamily: 'FontPuppins'),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30.0),
                            topRight: Radius.circular(30.0),
                          ),
                          color: Colors.white),
                      padding: const EdgeInsets.all(20),
                      child: SingleChildScrollView(
                        child: Form(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "Masukkan Email",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: Constants.primaryColor,
                                ),
                              ),
                              TextFormField(
                                controller: controller.emailController,
                                decoration: const InputDecoration(
                                  hintText: "Masukkan email",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                              ),
                              const SizedBox(
                                height: 20.0,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(double.infinity, 45), backgroundColor: Constants.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  controller.resetPassword(
                                      controller.emailController.text);
                                },
                                child: const Text(
                                  "Kirim",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    text: "Sudah punya akun? ",
                                    style: TextStyle(
                                      color: Constants.primaryColor,
                                      fontFamily: 'Poppins',
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Masuk",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Constants.primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.toNamed('/login');
                                          },
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
