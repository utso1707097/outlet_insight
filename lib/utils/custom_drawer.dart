import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outlet_insight/pages/login_page.dart';

import '../pages/OutlatePage.dart';

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
            decoration: BoxDecoration(
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
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.input),
            title: Text('Enter Outlet',style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => OutlatePage()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.view_list),
            title: Text('See Entered Outlet',style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),),
            onTap: () {
              // Navigate to see entered outlet page
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text('Logout',style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
