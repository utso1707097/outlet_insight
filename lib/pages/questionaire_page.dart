import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/custom_drawer.dart';

class QuestionairePage extends StatelessWidget {
  const QuestionairePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffC7F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xffC7F5F5),
        centerTitle: true,
        title: Text(
          "Questionaires",
          style: TextStyle(
            fontSize: 20.h,
            fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }
}
