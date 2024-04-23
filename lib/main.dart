import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:outlet_insight/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const MyHomPage(),
    );
  }
}

class MyHomPage extends StatelessWidget {
  const MyHomPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,designSize: const Size(360, 800),);
    return const LoginPage();
  }
}


