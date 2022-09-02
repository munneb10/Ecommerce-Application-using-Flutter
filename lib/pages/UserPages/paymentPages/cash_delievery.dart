// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import '../../../Widgets/Utility_Widgets/menu/menu.dart';
import '../../../utils/colors.dart';

class CashOnDelievery extends StatefulWidget {
  const CashOnDelievery({super.key});

  @override
  State<CashOnDelievery> createState() => _CashOnDelieveryState();
}

class _CashOnDelieveryState extends State<CashOnDelievery> {
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
                child: Column(children: [
                  SizedBox(
                    height: 15,
                  ),
                  AppMenu(
                    menu: true,
                    home: true,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width - 10,
                  //   child: Button(
                  //     buttonValue: "Cash on Delievery",
                  //     onclick: () {},
                  //   ),
                  // )
                ]))));
  }
}
