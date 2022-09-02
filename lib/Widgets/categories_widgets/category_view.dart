// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tst/utils/colors.dart';

class CategoryView extends StatefulWidget {
  CategoryView({Key? key}) : super(key: key);

  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
            visualDensity: VisualDensity.compact,
            side: BorderSide(color: AppColors.fore_background_begin),
            activeColor: AppColors.color,
            checkColor: AppColors.fore_background_begin,
            value: value,
            onChanged: (val) {
              setState(() {
                value = val!;
              });
            }),
        Text(
          "Category",
          style: TextStyle(
              color: AppColors.color,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
