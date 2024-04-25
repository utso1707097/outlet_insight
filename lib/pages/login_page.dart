import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:outlet_insight/pages/OutletPage.dart';

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
                  border: Border.all(color: const Color(0xFF01C0DC), width: 2,), // Set border color
                  borderRadius: BorderRadius.circular(30.w), // Optional: add border radius
                ),
                child: Obx(
                  ()=> TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none, // Hide the default border of the TextField
                      hintText: 'Enter username', // Placeholder text
                      suffixIcon: controller.nameError.value
                          ? Icon(Icons.error, color: Colors.red)
                          : Icon(Icons.person, color: Color(0xff9893A6)),
                      hintStyle: TextStyle(
                          color: const Color(0xff7E7B7B),
                          fontSize: 20.sp
                      ),
                      errorStyle: const TextStyle(
                          height: 0.01,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h), // Optional: adjust padding
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
                  border: Border.all(color: const Color(0xFF01C0DC), width: 2,), // Set border color
                  borderRadius: BorderRadius.circular(30.w), // Optional: add border radius
                ),
                child: Obx(
                  ()=> TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none, // Hide the default border of the TextField
                      hintText: 'Enter password', // Placeholder text
                      suffixIcon: controller.passwordError.value
                          ? Icon(Icons.error, color: Colors.red)
                          : Icon(Icons.person, color: Color(0xff9893A6)),
                      hintStyle: TextStyle(
                          color: const Color(0xff7E7B7B),
                          fontSize: 20.sp
                      ),
                      errorStyle: const TextStyle(
                        height: 0.01,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h), // Optional: adjust padding
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
              SizedBox(height: 50.h,),
              GestureDetector(
                onTap: () {
                  // Validate the form using _formKey
                  if (_formKey.currentState!.validate()) {
                    // Form is valid, proceed with your logic
                    print('Form is valid');
                    print('Name: ${controller.nameController.text}');
                    // Navigate to the next page
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OutletPage()),
                    );
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
                  child: Icon(Icons.arrow_forward_outlined, color: Colors.white, size: 40.h),
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

