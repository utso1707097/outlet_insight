import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:outlet_insight/controllers/shared_preference_controller.dart';
import 'package:outlet_insight/main.dart';
import 'package:outlet_insight/pages/entered_outlet_page.dart';
import 'package:outlet_insight/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/outlet_page.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xffC7F5F5),
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0273FD), Color(0xFF00D0FF)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Text(
                'User menu',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.input),
            title: Text(
              'Enter Outlet',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const OutletPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.view_list),
            title: Text(
              'See Entered Outlet',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () {
              // Navigate to see entered outlet page
              SharedPreferenceController cache = Get.find();
              log(cache.user?.userId ?? "");
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EnteredOutletPage(userId: cache.user?.userId ?? "")),
              );

            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(
              'Logout',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            onTap: () async {
              SharedPreferenceController cache = Get.find();
              await cache.logout();
              navigatorKey.currentState!.pop();
              navigatorKey.currentState!.pushReplacement(
                MaterialPageRoute(
                  builder: (context) => LoginPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
