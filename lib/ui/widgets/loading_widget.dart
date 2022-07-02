import 'package:flutter/material.dart';
import 'package:movies_app_task/utils/colors_utils.dart';

class LoadingWidget extends StatelessWidget {
  final Color color;
  const LoadingWidget({Key? key,this.color=ColorsUtils.blackColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: CircularProgressIndicator(
        color:color,
      ),
    );
  }
}
