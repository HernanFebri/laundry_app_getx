import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../profile/controllers/profile_controller.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var passwordVisible = true.obs;

  void login() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar('Error', 'Semua Form harus diisi');
      return;
    }

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (userCredential.user!.emailVerified) {
        Get.snackbar('Berhasil', 'Pengguna berhasil masuk');
        emailController.clear();
        passwordController.clear();

        // Fetch user data after successful login
        Get.find<ProfileController>().fetchUserData();

        // Delay navigation to avoid build issues
        Future.delayed(Duration.zero, () {
          Get.offNamed(Routes.HOME); // Navigate to HOME
        });
      } else {
        Get.snackbar('Error', 'Harap verifikasi email Anda');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'Email yang diberikan salah.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Password yang diberikan salah.');
      } else if (e.code == 'too-many-requests') {
        Get.snackbar('Error', 'Terlalu banyak permintaan. Coba lagi nanti.');
      } else {
        Get.snackbar(
            'Error', 'Terjadi kesalahan saat login. Silakan coba lagi nanti.');
        print(e);
      }
    } catch (e) {
      Get.snackbar(
          'Error', 'Terjadi kesalahan saat login. Silakan coba lagi nanti.');
      print(e);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
