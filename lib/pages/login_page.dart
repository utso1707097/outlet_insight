// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:outlet_insight/pages/outlet_page.dart';
import 'package:outlet_insight/utils/custom_alert_dialog.dart';
import 'package:outlet_insight/utils/custom_loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginController controller = Get.put(LoginController());
  @override
  void dispose() {
    super.dispose();
    _formKey.currentState?.dispose();
  }

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
                            ? const Icon(Icons.error, color: Colors.red)
                            : const Icon(Icons.person,
                                color: Color(0xff9893A6)),
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
                      obscureText: controller.isObsecure.value,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        // Hide the default border of the TextField
                        hintText: 'Enter password',
                        // Placeholder text
                        // suffixIcon: controller.passwordError.value
                        //     ? const Icon(Icons.error, color: Colors.red)
                        //     : const Icon(Icons.lock, color: Color(0xff9893A6)),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            controller.isObsecure.value =
                                !controller.isObsecure.value;
                          },
                          child: const Icon(
                            Icons.visibility,
                            color: Color(0xff9893A6),
                          ),
                        ),
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
                      final LoginController controller = Get.find();
                      controller.login(context);
                    }
                  },
                  child: Container(
                    width: 70.h,
                    height: 70.h,
                    decoration: const BoxDecoration(
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
}
