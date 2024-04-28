// ignore_for_file: use_build_context_synchronously
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:outlet_insight/controllers/shared_preference_controller.dart';
import 'package:outlet_insight/models/usermodel.dart';
import 'package:outlet_insight/pages/outlet_page.dart';
import 'package:outlet_insight/utils/custom_alert_dialog.dart';

import '../utils/custom_loading_indicator.dart';

class LoginController extends GetxController {
  // Instantiate TextFieldController
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  RxBool nameError = false.obs;
  RxBool passwordError = false.obs;
  RxBool isObsecure = true.obs;

  @override
  void onClose() {
    // Dispose the controllers when not needed
    nameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  Future<void> login(BuildContext context) async {
    String username = nameController.text.trim();
    String password = passwordController.text;
    SharedPreferenceController _cache = Get.find();

    try {
      FocusScope.of(context).unfocus();

      var url = Uri.parse('http://retail.isgalleon.com/api/login/login.php');
      var request = http.MultipartRequest('POST', url);

      request.fields['LoginId'] = username;
      request.fields['LoginPassword'] = password;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            elevation: 0,
            child: Center(
              child: CustomLoadingIndicator(), // Assuming CustomLoadingIndicator is your custom loading widget
            ),
          );
        },
      );
      var response = await http.Response.fromStream(await request.send());
      var jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        bool loginSuccess = json.decode(response.body)['success'];
        if (loginSuccess) {
          var sessionData = jsonResponse['sessionData'];
          UserModel user = UserModel.fromJson(sessionData);
          await _cache.saveUserInformation(user);
          nameController.clear();
          passwordController.clear();
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const OutletPage(),
            ),
          );
        } else {
          log("${response.statusCode} ${response.body}");
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomAlertDialog(
                title: 'Login failed',
                message: json.decode(response.body)['message'],
              );
            },
          );
        }
      } else {
        Navigator.pop(context);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return CustomAlertDialog(
                title: 'Login failed',
                message: json.decode(response.body)['message']);
          },
        );
      }
    } catch (error) {
      log('Error: $error');
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
              title: 'Login failed',
              message: "An unexpected error occurred. Please try again later.");
        },
      );
    }
  }
}
