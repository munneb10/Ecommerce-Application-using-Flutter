// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tst/utils/colors.dart';

// ignore: must_be_immutable
class TextInput extends StatelessWidget {
  ValueChanged onchange;
  String? textfieldvalue;
  VoidCallback? ontap;
  TextInput(
      {Key? key,
      required this.textfieldvalue,
      required this.onchange,
      this.ontap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width - 20,
          child: Row(children: [
            Flexible(
              child: TextFormField(
                onTap: () {
                  if (ontap != null) {
                    ontap!();
                  }
                },
                cursorHeight: 30,
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 30, color: AppColors.color),
                cursorColor: AppColors.color_lite.withOpacity(0.5),
                cursorWidth: 4.0,
                minLines: 1,
                maxLines: 6,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  border: InputBorder.none,
                  hintText: textfieldvalue,
                  isDense: true,
                  hintStyle: TextStyle(
                      color: AppColors.color.withOpacity(0.5),
                      fontSize: 30,
                      fontFamily: "Arial",
                      fontWeight: FontWeight.bold),
                ),
                onChanged: (value) {
                  onchange(value);
                },
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
