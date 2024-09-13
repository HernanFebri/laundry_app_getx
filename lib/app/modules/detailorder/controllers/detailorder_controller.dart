import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailorderController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> saveInvoiceAsImage() async {
    final status = await Permission.storage.request();
    if (status.isGranted) {
      screenshotController.capture().then((Uint8List? image) async {
        if (image != null) {
          final result = await ImageGallerySaver.saveImage(
              Uint8List.fromList(image),
              quality: 60,
              name: "invoice-${DateTime.now().toIso8601String()}.png");
          Get.snackbar("Success", "Invoice saved to gallery!");
        }
      }).catchError((onError) {
        Get.snackbar("Error", "Failed to save invoice: $onError");
      });
    } else {
      Get.snackbar("Permission Denied",
          "Storage permission is required to save images.");
    }
  }

  Future<void> saveInvoiceAndSendWhatsApp(
      String phoneNumber, String message) async {
    // Request permission to write to storage
    final status = await Permission.storage.request();
    if (status.isGranted) {
      // Capture screenshot
      screenshotController.capture().then((Uint8List? image) async {
        if (image != null) {
          // Save image to gallery
          final result = await ImageGallerySaver.saveImage(
            Uint8List.fromList(image),
            quality: 60,
            name: "invoice-${DateTime.now().millisecondsSinceEpoch}.png",
          );

          if (result['isSuccess'] == true) {
            Get.snackbar("Success", "Invoice saved to gallery!");

            // Save the image to a temporary directory
            final tempDir = await getTemporaryDirectory();
            final file = File('${tempDir.path}/invoice.png');
            await file.writeAsBytes(image);

            // Open WhatsApp with the image attached
            final whatsappUrl =
                'https://api.whatsapp.com/send?phone=$phoneNumber&text=${Uri.encodeComponent(message)}';

            if (await canLaunch(whatsappUrl)) {
              await launch(whatsappUrl);
            } else {
              Get.snackbar("Error", "Could not open WhatsApp");
            }
          } else {
            Get.snackbar("Error", "Failed to save invoice");
          }
        } else {
          Get.snackbar("Error", "Failed to capture screenshot");
        }
      }).catchError((onError) {
        Get.snackbar("Error", "Failed to capture screenshot: $onError");
      });
    } else {
      Get.snackbar("Permission Denied",
          "Storage permission is required to save images.");
    }
  }
}
