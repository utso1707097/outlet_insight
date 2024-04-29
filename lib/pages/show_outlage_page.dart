import 'dart:developer';

import 'package:flutter/material.dart';

class ShowOutletPage extends StatelessWidget {
  final Map<String, dynamic> outletData;
  const ShowOutletPage({super.key, required this.outletData});

  @override
  Widget build(BuildContext context) {
    log(outletData.toString());
    return const Placeholder();
  }
}
