import 'package:flutter/material.dart';

class JL {
  static double kDefaultPadding = 20;
  
  static TextStyle titleStyle = const TextStyle(color: Color.fromRGBO(217, 216, 217, 1), fontSize: 15, fontWeight: FontWeight.bold);
  static TextStyle subtitleStyle = const TextStyle(color: Color.fromRGBO(217, 216, 217, 0.6), fontSize: 11);

  static showLoading(BuildContext context) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        },
      );
  }

  static hideLoading(BuildContext context) {
    Navigator.pop(context);
  }

} 