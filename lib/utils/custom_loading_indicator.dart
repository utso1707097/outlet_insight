import 'package:flutter/material.dart';

class CustomLoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      backgroundColor: Colors.transparent.withOpacity(0),
      contentPadding: EdgeInsets.zero,
      content: FractionallySizedBox(
        widthFactor: 0.35,
        heightFactor: 0.1,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6.0), // Adjust the border radius as needed
          ),
          child: const Center(
            child: CircularProgressIndicator(
              strokeWidth: 4,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        ),
      ),
    );
  }
}