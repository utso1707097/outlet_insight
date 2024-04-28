import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:outlet_insight/controllers/dashboard_controller.dart';

class CustomDropdownField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final List<String> items;
  final DashboardController controller;
  final RxString fieldVar;
  final String? selectedValue; // Assuming you have a selected value variable

  const CustomDropdownField({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.items,
    required this.controller,
    required this.fieldVar,
    this.selectedValue,
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
          height: 55.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.w),
            color: Colors.white,
          ),
          child: Obx( ()=>
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: fieldVar.value.isNotEmpty
                    ? Text(
                  fieldVar.value,
                  style: TextStyle(
                    fontSize: 12.sp,
                    // fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                  overflow: TextOverflow.ellipsis,
                )
                    : Row(
                  children: [
                    Expanded(
                      child: Text(
                        hintText,
                        style: TextStyle(
                          fontSize: 12.sp,
                          // fontWeight: FontWeight.bold,
                          // color: const Color(0xff7E7B7B),
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                  ],
                ),
                items: items
                    .map((item) => DropdownMenuItem<String>(
                  value: item.toString(),
                  child: Text(
                    item.toString(),
                    style: TextStyle(
                      fontSize: 12.sp,
                      // fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
                    .toList(),
                value: fieldVar.value.isNotEmpty ? fieldVar.value : null,
                onChanged: (String? value) {
                  fieldVar.value = value!;
                },
                buttonStyleData: ButtonStyleData(
                  height: 48.h,
                  width: 259.w,
                  padding: EdgeInsets.only(left: 16.w, right: 14.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.w),
                    // border: Border.all(
                    //   color: Colors.black26,
                    // ),
                    // color: Colors.redAccent,
                  ),
                  // elevation: 2,
                ),
                // iconStyleData: IconStyleData(
                //   icon: Icon(
                //     Icons.arrow_forward_ios_outlined,
                //   ),
                //   iconSize: 14.sp,
                //   iconEnabledColor: Colors.yellow,
                //   iconDisabledColor: Colors.grey,
                // ),
                dropdownStyleData: DropdownStyleData(
                  maxHeight: 200.h,
                  width: 259.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.w),
                    // color: Colors.redAccent,
                  ),
                  offset: Offset(-20.w, 0),
                  scrollbarTheme: ScrollbarThemeData(
                    radius: Radius.circular(40.w),
                    thickness: MaterialStateProperty.all<double>(6.w),
                    thumbVisibility: MaterialStateProperty.all<bool>(true),
                  ),
                ),
                menuItemStyleData: MenuItemStyleData(
                  height: 40.h,
                  padding: EdgeInsets.only(left: 14.w, right: 14.w),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
