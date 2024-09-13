import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pelayanan_laundri/utils/constants.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.primaryColor,
      body: SafeArea(
        bottom: false,
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
                              "CREATE YOUR",
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
                              "Laundree! sudah menantikan kamu, ayo mulai laporkan keadaan terkini.",
                              textAlign: TextAlign.center,
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
                      color: Colors.white,
                    ),
                    padding: const EdgeInsets.all(24.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Nama Lengkap",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Constants.primaryColor,
                            ),
                          ),
                          TextField(
                            controller: controller.nameController,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: "Masukan nama lengkap",
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                )),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            "Email",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Constants.primaryColor,
                            ),
                          ),
                          TextField(
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Masukan email",
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
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
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Masukan password",
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15.0,
                          ),
                          Text(
                            "Konfirmasi Password",
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              color: Constants.primaryColor,
                            ),
                          ),
                          TextField(
                            controller: controller.confirmPasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: "Masukan konfirmasi password",
                              hintStyle: TextStyle(
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Constants.primaryColor,
                              minimumSize: Size(double.infinity, 50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: () {
                              controller.register();
                            },
                            child: Text(
                              "Register",
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Constants.scaffoldbackgroundColor),
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
                                      fontWeight: FontWeight.w600,
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
