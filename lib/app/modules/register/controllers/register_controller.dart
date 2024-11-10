import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;
  var passwordVisible = true.obs;
  var passwordVisibleconfirm = true.obs;

  late String userId;

  @override
  void onClose() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  @override
  void onInit() {
    nameController = TextEditingController();
    super.onInit();
  }

  void register() async {
    String email = emailController.text.trim();
    String name = nameController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (email.isEmpty ||
        name.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      Get.snackbar('Error', 'Semua form harus diisi');
      return;
    }

    if (password.length > 16) {
      Get.snackbar('Error', 'Password maksimal 16 karakter');
      return;
    }

    if (password != confirmPassword) {
      Get.snackbar('Error', 'Password tidak sama');
      return;
    }

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      userId = userCredential.user!.uid;
      await addData(userId, name, email);
      Get.snackbar('Berhasil', 'Pengguna berhasil dibuat');
      userCredential.user!.sendEmailVerification();
      Get.defaultDialog(
        title: 'Verifikasi email Anda',
        middleText:
            'Silakan verifikasi email Anda untuk melanjutkan. Kami telah mengirimkan tautan verifikasi email kepada Anda.',
        textConfirm: 'OK',
        textCancel: 'Kirim ulang',
        confirmTextColor: Colors.white,
        onConfirm: () {
          Get.offAllNamed(Routes.ONBOARDING);
        },
        onCancel: () {
          userCredential.user!.sendEmailVerification();
          Get.snackbar('Berhasil', 'Tautan verifikasi email terkirim');
        },
      );

      nameController.clear();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'Password yang diberikan terlalu lemah.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'Akun sudah ada untuk email tersebut.');
      } else {
        Get.snackbar('Error', e.message ?? 'Terjadi kesalahan');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', e.toString());
    }
  }

  Future<void> addData(String userId, String name, String email) async {
    try {
      await FirebaseFirestore.instance.collection('User').doc(userId).set({
        'name': name,
        'email': email,
      });
    } catch (e) {
      print(e);
    }
  }

  bool isNumeric(String s) {
    return double.tryParse(s) != null;
  }
}
