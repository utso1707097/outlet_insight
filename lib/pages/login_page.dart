import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outlet_insight/pages/OutlatePage.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffC7F5F5),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
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
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none, // Hide the default border of the TextField
                    hintText: 'Enter username', // Placeholder text
                    suffixIcon: const Icon(Icons.person,color: Color(0xff9893A6),),
                    hintStyle: TextStyle(
                      color: const Color(0xff7E7B7B),
                      fontSize: 20.sp
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h), // Optional: adjust padding
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
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none, // Hide the default border of the TextField
                    hintText: 'Enter password', // Placeholder text
                    suffixIcon: const Icon(Icons.lock,color: Color(0xff9893A6),),
                    hintStyle: TextStyle(
                        color: const Color(0xff7E7B7B),
                        fontSize: 20.sp
                    ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h), // Optional: adjust padding
                  ),
                ),
              ),
              SizedBox(height: 50.h,),
              Container(
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
                child: IconButton(
                  icon: Icon(Icons.arrow_forward_outlined, color: Colors.white, size: 40.h),
                  onPressed: () {
                    // Add your onPressed callback here
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => OutlatePage()),
                    );
                  },
                ),
              )
          
          
            ],
          ),
        ),
      ),
    );
  }
}
