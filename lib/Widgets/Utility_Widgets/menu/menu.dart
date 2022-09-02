// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_import, curly_braces_in_flow_control_structures, avoid_unnecessary_containers, prefer_typing_uninitialized_variables, must_be_immutable
// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_tst/utils/colors.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/menu/options.dart';

class AppMenu extends StatelessWidget {
  BuildContext? context;
  bool menu;
  bool filter;
  bool home;
  bool cart;
  VoidCallback? onmenuclick;
  AppMenu(
      {Key? key,
      this.menu = false,
      this.filter = false,
      this.home = false,
      this.cart = false,
      this.onmenuclick})
      : super(key: key);
  List<Widget> menu_to_display() {
    List<Widget> menu_items = <Widget>[];
    if (home == true) {
      menu_items.add(Options(
        onclick: () {
          Navigator.of(context!).pushNamedAndRemoveUntil(
              '/AllProducts', (Route<dynamic> route) => false);
        },
        ic: Icons.home_rounded,
        size: 50,
        fontSize: 15,
        color: AppColors.color,
        text: "Home",
      ));
      menu_items.add(SizedBox(
        width: 10,
      ));
    }
    if (cart == true) {
      menu_items.add(Options(
          ic: Icons.shopping_cart_rounded,
          size: 50,
          fontSize: 15,
          color: AppColors.color,
          text: "Cart"));
      menu_items.add(SizedBox(
        width: 10,
      ));
    }

    if (filter == true) {
      menu_items.add(Options(
        ic: Icons.tune_rounded,
        color: AppColors.color,
        fontSize: 15,
        size: 50,
        text: "Filter",
      ));
      menu_items.add(SizedBox(
        width: 10,
      ));
    }
    if (menu == true) {
      menu_items.add(Options(
        onclick: () {
          if (onmenuclick != null) {
            onmenuclick!();
          }
        },
        ic: Icons.menu_rounded,
        fontSize: 15,
        size: 50,
        color: AppColors.color,
        text: "Menu",
      ));
      menu_items.add(SizedBox(
        width: 10,
      ));
    }

    return menu_items;
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: menu_to_display()),
    );
  }
}
