import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:outlet_insight/controllers/dashboard_controller.dart';
import 'package:outlet_insight/controllers/home_page_controller.dart';
import 'package:outlet_insight/pages/camera_page.dart';
import 'package:outlet_insight/pages/login_page.dart';
import 'package:outlet_insight/widgets/custom_loading_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'pages/outlet_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Outlet Insight App',
      theme: ThemeData(
        fontFamily: 'Nunito',
        textTheme: const TextTheme(
          bodyMedium: TextStyle(fontWeight: FontWeight.w400), // Regular
          displayLarge: TextStyle(fontWeight: FontWeight.w700), // Bold
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final HomePageController homePageController = Get.put(HomePageController());

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(360, 800));
    return Obx(() {
     if (homePageController.seen) {
        return OutletPage();
      } else {
        return LoginPage();
      }
    });
  }
}

