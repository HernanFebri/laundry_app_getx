import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pelayanan_laundri/utils/constants.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
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
                            Get.back();
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
                                "LOGIN",
                                style: TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                "ACCOUNT",
                                style: TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                "Laundree! sudah menantikan kamu, ayo mulai laporkan keadaan terkini.",
                                style: TextStyle(
                                  fontSize: 14.0,
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                ),
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
                                "Email",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Constants.primaryColor,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                              TextField(
                                controller: controller.emailController,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Email",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                  ),
                                  prefixIcon: Icon(Icons.email),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              Text(
                                "Password",
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  color: Constants.primaryColor,
                                ),
                              ),
                              TextField(
                                controller: controller.passwordController,
                                obscureText: true,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: "Password",
                                  hintStyle: TextStyle(
                                    fontFamily: 'Poppins',
                                  ),
                                  prefixIcon: Icon(Icons.lock),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(double.infinity, 45),
                                  backgroundColor: Constants.primaryColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  controller.login();
                                },
                                child: Text(
                                  "Masuk",
                                  style: TextStyle(
                                    fontFamily: 'Poppins',
                                    color: Constants.scaffoldbackgroundColor,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Align(
                                alignment: Alignment.topRight,
                                child: TextButton(
                                  onPressed: () {
                                    Get.toNamed('/lupa-password');
                                  },
                                  child: Text(
                                    "Lupa Password?",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Constants.primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Center(
                                child: RichText(
                                  text: TextSpan(
                                    text: "Belum punya akun? ",
                                    style: TextStyle(
                                      fontFamily: 'Poppins',
                                      color: Constants.primaryColor,
                                    ),
                                    children: [
                                      TextSpan(
                                        text: "Daftar Sekarang",
                                        style: TextStyle(
                                          fontFamily: 'Poppins',
                                          color: Constants.primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Get.toNamed('/register');
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
