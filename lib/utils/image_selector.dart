import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:outlet_insight/controllers/dashboard_controller.dart';
import 'package:outlet_insight/pages/camera_page.dart';

class ImageSelector extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final RxString fieldVar;

  const ImageSelector({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.fieldVar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image Container with Title
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CameraPageWithGallery(fieldVar: fieldVar,)),
            );
          },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
              width: 300.w,
              height: 240.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12.w),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 3,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              ),
              child: Obx(
                ()=> Stack(
                  children: [
                    Positioned.fill(
                      child: fieldVar.value != ""
                          ? Image.memory(
                        base64Decode(fieldVar.value),
                        fit: BoxFit.cover,
                      )
                          : Center(
                        child: ShaderMask(
                          shaderCallback: (bounds) {
                            return LinearGradient(
                              colors: [Color(0xFF0273FD), Color(0xFF00D0FF)],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ).createShader(bounds);
                          },
                          child: Icon(Icons.image, color: Colors.white, size: 100.sp),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10.h,
                      right: 10.w,
                      child: Icon(Icons.camera_alt, color: Color(0xff008DDF), size: 30.sp),
                    ),
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFF0273FD), Color(0xFF00D0FF)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12.w),
                            topLeft: Radius.circular(12.w),
                          ),
                        ),
                        padding: EdgeInsets.all(12.w),
                        child: Center(
                          child: Text(
                            hintText,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ),
        // Text Field
      ],
    );
  }
}
