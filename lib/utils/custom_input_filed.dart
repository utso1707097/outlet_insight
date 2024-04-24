import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInputField extends StatelessWidget {
  final IconData icon;
  final String hintText;

  const CustomInputField({
    Key? key,
    required this.icon,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          height: 40.h,
          width: 40.h,
          decoration: BoxDecoration(
            color: Color(0xff008DDF),
            borderRadius: BorderRadius.circular(40.h),
          ),
          child: Icon(icon, size: 24.h, color: Colors.white),
        ),
        SizedBox(width: 10.w),
        Container(
          width: 259.w,
          height: 48.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.w),
            color: Colors.white,
          ),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: TextStyle(
                color: const Color(0xff7E7B7B),
                fontSize: 12.sp,
              ),
              contentPadding:
              EdgeInsets.symmetric(horizontal: 20.w),
            ),
          ),
        ),
      ],
    );
  }
}