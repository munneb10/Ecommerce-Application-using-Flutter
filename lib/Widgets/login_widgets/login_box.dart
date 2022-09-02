// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tst/utils/colors.dart';

class LoginBox extends StatelessWidget {
  String input_value;
  LoginBox({Key? key, required this.input_value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          child: Row(children: [
            Flexible(
              child: TextFormField(
                cursorHeight: 30,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 30, color: AppColors.color),
                cursorColor: AppColors.color,
                cursorWidth: 4.0,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  border: InputBorder.none,
                  hintText: input_value,
                  isDense: true,
                  hintStyle: TextStyle(
                      color: AppColors.color_lite,
                      fontSize: 30,
                      fontFamily: "Arial",
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ]),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          child: Divider(
            thickness: 3.0,
            color: AppColors.color,
          ),
        )
      ],
    );
  }
}
