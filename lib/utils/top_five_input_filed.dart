import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:outlet_insight/controllers/dashboard_controller.dart';

class TopBrandsInputField extends StatelessWidget {
  final DashboardController controller;

  final bool isRequired;

  const TopBrandsInputField(
      {super.key, required this.controller, this.isRequired = true});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(0),
                height: 40.h,
                width: 40.h,
                decoration: BoxDecoration(
                  color: const Color(0xff008DDF),
                  borderRadius: BorderRadius.circular(40.h),
                ),
                child: Icon(Icons.branding_watermark_outlined,
                    size: 24.h, color: Colors.white),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: Text(
                  'Top 5 brands based on product sale\'s value:',
                  style: TextStyle(fontSize: 12.sp),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Obx (
                ()=> Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.h),
                  ),
                  width: 249.w,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 48.h,
                        child: TextFormField(
                          onChanged: (text) {
                            // Update the fieldVar in the DashboardController
                            controller.brand1.value = text;
                          },
                          decoration: InputDecoration(
                            suffixIcon:
                                isRequired && controller.brand1.value.isEmpty
                                    ? Icon(
                                        Icons.star,
                                        color: Colors.red,
                                        size: 8.sp,
                                      )
                                    : null,
                            hintText: 'Brand 1',
                            hintStyle: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xff7E7B7B),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 12.w),
                            //border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      //SizedBox(height: 10.h), // Add some vertical spacing between TextFields
                      SizedBox(
                        height: 48.h,
                        child: TextFormField(
                          onChanged: (text) {
                            // Update the fieldVar in the DashboardController
                            controller.brand2.value = text;
                          },
                          decoration: InputDecoration(
                            suffixIcon:
                                isRequired && controller.brand2.value.isEmpty
                                    ? Icon(
                                        Icons.star,
                                        color: Colors.red,
                                        size: 8.sp,
                                      )
                                    : null,
                            hintText: 'Brand 2',
                            hintStyle: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xff7E7B7B),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 12.w),
                            // border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      //SizedBox(height: 10.h), // Add some vertical spacing between TextFields
                      SizedBox(
                        height: 48.h,
                        child: TextFormField(
                          onChanged: (text) {
                            // Update the fieldVar in the DashboardController
                            controller.brand3.value = text;
                          },
                          decoration: InputDecoration(
                            suffixIcon:
                                isRequired && controller.brand3.value.isEmpty
                                    ? Icon(
                                        Icons.star,
                                        color: Colors.red,
                                        size: 8.sp,
                                      )
                                    : null,
                            hintText: 'Brand 3',
                            hintStyle: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xff7E7B7B),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 12.w),
                            //border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      //SizedBox(height: 10.h), // Add some vertical spacing between TextFields
                      SizedBox(
                        height: 48.h,
                        child: TextFormField(
                          onChanged: (text) {
                            // Update the fieldVar in the DashboardController
                            controller.brand4.value = text;
                          },
                          decoration: InputDecoration(
                            suffixIcon:
                                isRequired && controller.brand4.value.isEmpty
                                    ? Icon(
                                        Icons.star,
                                        color: Colors.red,
                                        size: 8.sp,
                                      )
                                    : null,
                            hintText: 'Brand 4',
                            hintStyle: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xff7E7B7B),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 12.w),
                            //border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      //SizedBox(height: 10.h), // Add some vertical spacing between TextFields
                      SizedBox(
                        height: 48.h,
                        child: TextFormField(
                          onChanged: (text) {
                            // Update the fieldVar in the DashboardController
                            controller.brand5.value = text;
                          },
                          decoration: InputDecoration(
                            suffixIcon:
                                isRequired && controller.brand5.value.isEmpty
                                    ? Icon(
                                        Icons.star,
                                        color: Colors.red,
                                        size: 8.sp,
                                      )
                                    : null,
                            hintText: 'Brand 5',
                            hintStyle: TextStyle(
                              fontSize: 12.sp,
                              color: const Color(0xff7E7B7B),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 8.h, horizontal: 12.w),
                            //border: OutlineInputBorder(),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
