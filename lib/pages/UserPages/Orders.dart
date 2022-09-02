// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tst/Widgets/Orders_Widgets/orders_tile_view.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/menu/menu.dart';
import 'package:flutter_tst/utils/colors.dart';

class UserOrders extends StatefulWidget {
  UserOrders({Key? key}) : super(key: key);

  @override
  _UserOrdersState createState() => _UserOrdersState();
}

class _UserOrdersState extends State<UserOrders> {
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
                "Your Orders",
                style: TextStyle(
                    color: AppColors.color,
                    fontSize: 30,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return OrderTile();
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
