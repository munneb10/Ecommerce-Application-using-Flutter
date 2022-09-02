// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/button.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/input.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/menu/menu.dart';
import 'package:flutter_tst/Widgets/adminpage_widgets/add_category_widgets.dart/category_edit_view.dart';
import 'package:flutter_tst/utils/colors.dart';
import 'package:flutter_tst/utils/keyboarddetector.dart/keyboarddetector.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool iskeyboardopen = false;
  bool isAddCategory = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Material(
      child: KeyBoardDetector(
        onkeyboardclose: () {
          setState(() {
            iskeyboardopen = false;
          });
        },
        onkeyboardopen: () {
          setState(() {
            iskeyboardopen = true;
          });
        },
        child: Stack(children: [
          Container(
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
                AppMenu(menu: true, home: true),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "All Categories",
                  style: TextStyle(
                      color: AppColors.color,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Input_box(
                  textfieldvalue: "Search Category",
                  issearch: true,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "150 Categories",
                  style: TextStyle(
                      color: AppColors.color,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Button(
                    buttonValue: "Add Category",
                    onclick: () {
                      setState(() {
                        isAddCategory = true;
                      });
                    }),
                Flexible(
                  child: ListView.builder(
                    itemCount: 25,
                    itemBuilder: (context, index) {
                      return EditCategoryView();
                    },
                  ),
                )
              ],
            ),
          ),
          isAddCategory
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black.withOpacity(0.3),
                  child: Align(
                    alignment:
                        iskeyboardopen ? Alignment.topCenter : Alignment.center,
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                            AppColors.fore_background_begin,
                            AppColors.fore_background_end
                          ])),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          Input_box(
                            textfieldvalue: "Category Name",
                            onchange: (val) {},
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Button(buttonValue: "Add Category", onclick: () {}),
                          SizedBox(
                            height: 20,
                          ),
                          Button(
                              buttonValue: "Cancel",
                              onclick: () {
                                setState(() {
                                  isAddCategory = false;
                                });
                              })
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
        ]),
      ),
    ));
  }
}
