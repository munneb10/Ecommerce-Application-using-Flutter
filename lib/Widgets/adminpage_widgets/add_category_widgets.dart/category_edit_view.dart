// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tst/utils/colors.dart';

class EditCategoryView extends StatefulWidget {
  EditCategoryView({Key? key}) : super(key: key);

  @override
  State<EditCategoryView> createState() => _EditCategoryViewState();
}

class _EditCategoryViewState extends State<EditCategoryView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 8, top: 6),
                child: Text(
                  "Category",
                  style: TextStyle(
                      color: AppColors.color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  print("Wanna Edit");
                },
                child: Text(
                  "Edit",
                  style: TextStyle(
                      color: AppColors.color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Wanna Delete");
                },
                child: Text(
                  "Delete",
                  style: TextStyle(
                      color: AppColors.color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
