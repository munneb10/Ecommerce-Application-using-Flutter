// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/button.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/input.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/menu/menu.dart';
import 'package:flutter_tst/Widgets/categories_widgets/category_view.dart';
import 'package:flutter_tst/utils/colors.dart';

class CategoriesPage extends StatefulWidget {
  CategoriesPage({Key? key}) : super(key: key);

  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                AppColors.base_background_begin,
                AppColors.base_background_end
              ])),
          child: Column(
            children: [
              SizedBox(
                height: 16,
              ),
              AppMenu(
                menu: true,
                cart: true,
              ),
              SizedBox(
                height: 20,
              ),
              Input_box(
                textfieldvalue: "Search Category",
                issearch: true,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "150 Categories",
                style: TextStyle(
                    color: AppColors.color,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Button(buttonValue: "Search", onclick: () {}),
              Flexible(
                child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return CategoryView();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
