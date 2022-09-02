// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_tst/utils/colors.dart';

class Options extends StatelessWidget {
  IconData ic;
  double size;
  double fontSize;
  VoidCallback? onclick;
  Color color;
  String text;
  @override
  Options(
      {Key? key,
      this.ic = Icons.warning,
      this.size = 50,
      this.fontSize = 15,
      this.color = AppColors.color,
      this.text = "",
      this.onclick})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onclick != null) {
          onclick!();
        }
      },
      child: Column(
        children: [
          Icon(
            ic,
            color: color,
            size: size,
          ),
          Text(
            text,
            style: TextStyle(color: color, fontSize: fontSize),
          )
        ],
      ),
    );
  }
}
