import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CustomInputField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final RxString fieldVar;
  final TextInputType inputType;
  final bool isRequired;

  const CustomInputField({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.fieldVar,
    required this.inputType,
    this.isRequired = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(0),
          height: 40.h,
          width: 40.h,
          decoration: BoxDecoration(
            color: const Color(0xff008DDF),
            borderRadius: BorderRadius.circular(40.h),
          ),
          child: Icon(icon, size: 24.h, color: Colors.white),
        ),
        SizedBox(width: 10.w),
        Container(
          width: 259.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.w),
            color: Colors.white,
          ),
          child: Obx(
           () => TextFormField(
              onChanged: (text) {
                // Update the fieldVar in the DashboardController
                fieldVar.value = text;
              },
              initialValue: fieldVar.value.isEmpty ? null : fieldVar.value,
              keyboardType: inputType,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                suffixIcon: isRequired && fieldVar.value.isEmpty
                    ? Icon(Icons.star, color: Colors.red,size: 8.sp,)
                    : null,
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: const Color(0xff7E7B7B),
                  fontSize: 12.sp,
                ),
                hintMaxLines: 3,
                contentPadding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                // contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
