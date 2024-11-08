import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../utils/constants.dart';

class ProfileController extends GetxController {
  var imagePath = ''.obs;
  var name = ''.obs;
  var email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userData = await FirebaseFirestore.instance
          .collection('User')
          .doc(user.uid)
          .get();

      name.value = userData['name'];
      email.value = userData['email'];
      // Memeriksa apakah field imagePath ada dan bukan null
      imagePath.value = (userData.data() as Map<String, dynamic>?)
                  ?.containsKey('imagePath') ==
              true
          ? userData['imagePath']
          : ''; // Nilai default jika tidak ada imagePath
    }
  }

  Future<void> pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      String imageUrl = await uploadImage(image);
      imagePath.value = imageUrl;
      await updateProfileImage(imageUrl);
    }
  }

  Future<String> uploadImage(XFile image) async {
    Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('profile_images')
        .child(FirebaseAuth.instance.currentUser!.uid + '.jpg');
    await storageRef.putFile(File(image.path));
    return await storageRef.getDownloadURL();
  }

  Future<void> updateProfileImage(String imageUrl) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(user.uid)
          .update({'imagePath': imageUrl});
    }
  }

  void showEditNameDialog(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    nameController.text = name.value;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Edit Nama',
            style: TextStyle(
              color: Constants.primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              hintText: 'Nama baru',
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                updateUserName(nameController.text);
                Navigator.of(context).pop();
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Future<void> updateUserName(String newName) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('User')
          .doc(user.uid)
          .update({'name': newName});
      name.value = newName;
    }
  }

  void showLogoutConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          alignment: Alignment.center,
          content: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Apakah Anda yakin ingin logout?',
              style: TextStyle(
                color: Constants.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 35),
                    backgroundColor: Constants.primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Batal",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Constants.scaffoldbackgroundColor,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(100, 35),
                    backgroundColor: Constants.fourColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  onPressed: () {
                    logout();
                  },
                  child: Text(
                    "Keluar",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Constants.scaffoldbackgroundColor,
                    ),
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed('/onboarding');
  }
}
