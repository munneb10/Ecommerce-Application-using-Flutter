// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/menu/menu.dart';
import 'package:flutter_tst/utils/colors.dart';

class SalesShowPage extends StatefulWidget {
  const SalesShowPage({Key? key}) : super(key: key);

  @override
  State<SalesShowPage> createState() => _SalesShowPageState();
}

class _SalesShowPageState extends State<SalesShowPage> {
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
              "Order Details",
              style: TextStyle(
                  color: AppColors.color,
                  fontSize: 30,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "Total Orders : 100",
              style: TextStyle(
                  color: AppColors.color,
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Orders in progress : 100",
                        style: TextStyle(
                            color: AppColors.color,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Orders ready to delivered : 100",
                        style: TextStyle(
                            color: AppColors.color,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Orders on the way : 100",
                        style: TextStyle(
                            color: AppColors.color,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        "Orders delivered : 100",
                        style: TextStyle(
                            color: AppColors.color,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
