// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tst/utils/colors.dart';

class UserNameRole extends StatefulWidget {
  const UserNameRole({Key? key}) : super(key: key);

  @override
  State<UserNameRole> createState() => _UserNameRoleState();
}

class _UserNameRoleState extends State<UserNameRole> {
  List rnd = ["Seller", "Buyer"];
  var rng = Random();
  int i = 0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "User ${rng.nextInt(25)}",
              style: TextStyle(
                  color: AppColors.color,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              rnd[rng.nextInt(2)],
              style: TextStyle(
                  color: AppColors.color,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
