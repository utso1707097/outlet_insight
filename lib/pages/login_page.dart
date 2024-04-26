import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:outlet_insight/pages/OutletPage.dart';
import 'package:outlet_insight/utils/custom_alert_dialog.dart';
import 'package:outlet_insight/utils/custom_loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/login_controller.dart';

class LoginPage extends StatelessWidget {
  final LoginController controller = Get.put(LoginController());
  static GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffC7F5F5),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 283.h,
                ),
                Container(
                  height: 100.h,
                  child: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 54.sp,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 60.h,
                  width: 250.w,
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF01C0DC),
                      width: 2,
                    ),
                    // Set border color
                    borderRadius: BorderRadius.circular(
                        30.w), // Optional: add border radius
                  ),
                  child: Obx(
                    () => TextFormField(
                      controller: controller.nameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        // Hide the default border of the TextField
                        hintText: 'Enter username',
                        // Placeholder text
                        suffixIcon: controller.nameError.value
                            ? Icon(Icons.error, color: Colors.red)
                            : Icon(Icons.person, color: Color(0xff9893A6)),
                        hintStyle: TextStyle(
                            color: const Color(0xff7E7B7B), fontSize: 20.sp),
                        errorStyle: const TextStyle(
                          height: 0.01,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 12.h), // Optional: adjust padding
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          controller.nameError.value = true;
                          return '';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  height: 60.h,
                  width: 250.w,
                  padding: const EdgeInsets.all(0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF01C0DC),
                      width: 2,
                    ),
                    // Set border color
                    borderRadius: BorderRadius.circular(
                        30.w), // Optional: add border radius
                  ),
                  child: Obx(
                    () => TextFormField(
                      controller: controller.passwordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        // Hide the default border of the TextField
                        hintText: 'Enter password',
                        // Placeholder text
                        suffixIcon: controller.passwordError.value
                            ? Icon(Icons.error, color: Colors.red)
                            : Icon(Icons.lock, color: Color(0xff9893A6)),
                        hintStyle: TextStyle(
                            color: const Color(0xff7E7B7B), fontSize: 20.sp),
                        errorStyle: const TextStyle(
                          height: 0.01,
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                            vertical: 12.h), // Optional: adjust padding
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          controller.passwordError.value = true;
                          return '';
                        }
                        return null;
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                GestureDetector(
                  onTap: () async {
                    // Validate the form using _formKey
                    if (_formKey.currentState!.validate()) {
                      _submitForm(context);
                    }
                  },
                  child: Container(
                    width: 70.h,
                    height: 70.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF0273FD), Color(0xFF00D0FF)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                    child: Icon(Icons.arrow_forward_outlined,
                        color: Colors.white, size: 40.h),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomLoadingIndicator();
      },
    );
    String username = controller.nameController.text.trim();
    String password = controller.passwordController.text;

    try {
      FocusScope.of(context).unfocus();

      var url = Uri.parse('http://retail.isgalleon.com/api/login/login.php');
      var request = http.MultipartRequest('POST', url);

      request.fields['LoginId'] = username;
      request.fields['LoginPassword'] = password;

      var response = await http.Response.fromStream(await request.send());
      var jsonResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        bool loginSuccess = json.decode(response.body)['success'];
        if (loginSuccess) {
          // print('Login successful! Response: ${response.body}');
          var sessionData = jsonResponse['sessionData'];
          // print("Executed");
          await saveSessionData(sessionData);
          print(sessionData);
          Navigator.pop(context);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => OutletPage(),
            ),
          );
        } else {
          Navigator.pop(context);
          print("${response.statusCode} ${response.body}");

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return CustomAlertDialog(
                  title: 'Login failed',
                  message: json.decode(response.body)['message']);
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
      print('Error: $error');
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

  Future<void> saveSessionData(Map<String, dynamic> sessionData) async {
    //print(sessionData);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool("seen", true);
      prefs.setString("user_password", controller.passwordController.text);
      prefs.setString("user_id", sessionData["user_id"].toString() ?? "");
      prefs.setString("user_name", sessionData["user_name"].toString() ?? "");
      prefs.setString("full_name", sessionData["full_name"].toString() ?? "");
      prefs.setString(
          "user_type_id", sessionData["user_type_id"].toString() ?? "");
      prefs.setString(
          "user_type_name", sessionData["user_type_name"].toString() ?? "");
      prefs.setString(
          "picture_name", sessionData["picture_name"].toString() ?? "");
      print(prefs.getString("user_name"));
      print("He HE he");
    } catch (error) {
      print('Error saving session data: $error');
    }
  }
}
