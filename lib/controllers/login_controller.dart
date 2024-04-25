import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  // Instantiate TextFieldController
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool nameError = false.obs;
  RxBool passwordError = false.obs;

  @override
  void onClose() {
    // Dispose the controllers when not needed
    nameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}