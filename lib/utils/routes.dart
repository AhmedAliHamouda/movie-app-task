
import 'package:flutter/material.dart';

class CustomNavigator {
  static final navigatorKey = GlobalKey<NavigatorState>();

  static pushScreen({required Widget widget, required BuildContext context}) {
    Navigator.push(context, MaterialPageRoute(builder: (ctx) => widget));
  }

  static popScreen(BuildContext context) {
    Navigator.pop(context);
  }

  static pushScreenReplacement({required Widget widget, required BuildContext context}) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => widget));
  }

  static pushScreenReplacementAll({required Widget widget, required BuildContext context}) {
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (c) => widget), (route) => false);
  }

}


