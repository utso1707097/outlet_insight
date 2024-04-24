import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:outlet_insight/pages/questionaire_page.dart';
import 'package:outlet_insight/utils/custom_drawer.dart';

import '../controllers/dashboard_controller.dart';
import '../utils/custom_input_filed.dart';
import '../utils/image_selector.dart';

class OutlatePage extends StatelessWidget {
  const OutlatePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DashboardController controller =
    Get.put(DashboardController());
    return Scaffold(
      backgroundColor: const Color(0xffC7F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xffC7F5F5),
        centerTitle: true,
        title: Text(
          "Enter Outlet Details",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20.h,
          ),
        ),
      ),
      drawer: CustomDrawer(),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20.h),
              CustomInputField(
                icon: Icons.shop,
                hintText: 'Enter outlet name',
              ),
              SizedBox(height: 12.h),
              CustomInputField(
                icon: Icons.manage_accounts,
                hintText: 'Enter owner name',
              ),
              SizedBox(height: 12.h),
              CustomInputField(
                icon: Icons.phone,
                hintText: 'Enter owner mobile',
              ),
              SizedBox(height: 12.h),
              CustomInputField(
                icon: Icons.area_chart,
                hintText: 'Enter area details',
              ),
              SizedBox(height: 10.h),
              ImageSelector(
                icon: Icons.photo,
                hintText: 'Select outlet interior image',
                cameraType: 'interior',
                controller: controller,
              ),
              //SizedBox(height: 10.h),
              ImageSelector(
                icon: Icons.photo,
                hintText: 'Select outlet exterior image',
                cameraType: 'exterior',
                controller: controller,

              ),
              //SizedBox(height: 10.h),
              ImageSelector(
                icon: Icons.photo,
                hintText: 'Select outlet front image',
                cameraType: 'front',
                controller: controller,
              ),
              //SizedBox(height: 10.h),
              ImageSelector(
                icon: Icons.photo,
                hintText: 'Select outlet back image',
                cameraType: 'back',
                controller: controller,
              ),
              SizedBox(height: 10.h),
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
                  icon: Icon(Icons.check, color: Colors.white, size: 40.h),
                  onPressed: () {
                    print(controller.interiorBase64Image.value);
                    print(controller.exteriorBase64Image.value);
                    print(controller.frontBase64Image.value);
                    print(controller.backBase64Image.value);
                    // Add your onPressed callback here
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => QuestionairePage()),
                    // );
                  },
                ),
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
