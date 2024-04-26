import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CustomTimerPicker extends StatefulWidget {
  final IconData icon;
  final String hintText;
  final RxString fieldVar;

  const CustomTimerPicker({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.fieldVar,
  }) : super(key: key);

  @override
  State<CustomTimerPicker> createState() => _CustomTimerPickerState();
}

class _CustomTimerPickerState extends State<CustomTimerPicker> {
  TimeOfDay? _timeOfDay;

  String convertDateTime(String timeString) {
    DateTime time = DateFormat.Hm().parse(timeString);

    // Format the DateTime object into the desired format
    String formattedTime = DateFormat('h:mm a').format(time);

    return formattedTime;
  }

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
          child: Icon(widget.icon, size: 24.h, color: Colors.white),
        ),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: () async {
            final TimeOfDay? selectedTime = await showTimePicker(
              initialTime: TimeOfDay.now(),
              context: context,
            );

            setState(() {
              _timeOfDay = selectedTime;
            });
            widget.fieldVar.value =
                "${_timeOfDay?.hour ?? ""}:${_timeOfDay?.minute ?? ""}";
          },
          child: Container(
            alignment: Alignment.centerLeft,
            width: 259.w,
            height: 48.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.w),
              color: Colors.white,
            ),
            child: Text(
              widget.fieldVar.value == ""
                  ? "Choose time"
                  : convertDateTime(widget.fieldVar.value),
            ).paddingSymmetric(horizontal: 20.w),
          ),
        ),
      ],
    );
  }
}
