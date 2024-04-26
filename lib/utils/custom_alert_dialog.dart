import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String message;

  CustomAlertDialog({required this.title, required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0.w),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0.w),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: EdgeInsets.all(16.h),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0273FD), Color(0xFF00D0FF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10.0.w),
                  topRight: Radius.circular(10.0.w),
                ),
              ),
              // padding: EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.error_outline,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                  SizedBox(width: 8.0.w),
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16.0.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.0.w,
              ),
            ),
            // SizedBox(height: 8.h),
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(16.h),
                //color: Colors.blue,
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            // SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}
