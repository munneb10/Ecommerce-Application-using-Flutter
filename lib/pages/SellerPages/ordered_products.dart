// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/input.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/menu/menu.dart';
import 'package:flutter_tst/Widgets/sellerpage_widgets/ordered_product_widgets/ordered_product_tile.dart';
import 'package:flutter_tst/utils/colors.dart';

class OrederedProducts extends StatefulWidget {
  const OrederedProducts({Key? key}) : super(key: key);

  @override
  State<OrederedProducts> createState() => _OrederedProductsState();
}

class _OrederedProductsState extends State<OrederedProducts> {
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
              height: 15,
            ),
            AppMenu(
              menu: true,
              home: true,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "All Orders",
              style: TextStyle(
                  color: AppColors.color,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Input_box(
              textfieldvalue: "Search",
              issearch: true,
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return OrderedProductTile();
                  }),
            )
          ],
        ),
      ),
    ));
  }
}
