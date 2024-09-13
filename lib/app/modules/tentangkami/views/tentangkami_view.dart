import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/tentangkami_controller.dart';

class TentangkamiView extends GetView<TentangkamiController> {
  const TentangkamiView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TentangkamiView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TentangkamiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
