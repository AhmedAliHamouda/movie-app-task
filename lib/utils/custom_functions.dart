import 'package:flutter/material.dart';

class CustomFunctions {
  static void showCustomSnackBar({
    required String? text,
    bool? hasIcon=false,
    IconData? iconType,
    required BuildContext context,
    Color? iconColor,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: backgroundColor,
      content: Row(
        children: [
          hasIcon!
              ? Icon(
            iconType,
            color: iconColor,
          )
              : Container(
            height: 22.0,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text!,
              style: const TextStyle(fontSize: 14.0),
            ),
          ),
        ],
      ),
    ));
  }
}
