// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_tst/utils/colors.dart';

class rating extends StatefulWidget {
  ValueChanged<int> onchanged;
  rating({Key? key, required this.onchanged}) : super(key: key);

  @override
  _ratingState createState() => _ratingState();
}

class _ratingState extends State<rating> {
  late List<Widget> rates = [];
  late int rates_value = 0;
  void change_rates() {
    rates.clear();
    for (var i = 0; i < 5; i++) {
      rates.add(InkWell(
          onTap: () => setState(() {
                widget.onchanged(i + 1);
                rates_value = i + 1;
                change_rates();
              }),
          child: Icon(
            i < rates_value
                ? Icons.star_rate_rounded
                : Icons.star_border_rounded,
            size: 40,
            color: AppColors.color,
          )));
    }
  }

  @override
  void initState() {
    for (var i = 0; i < 5; i++) {
      rates.add(InkWell(
          onTap: () => setState(() {
                rates_value = i + 1;
                change_rates();
              }),
          child: Icon(
            i < rates_value
                ? Icons.star_rate_rounded
                : Icons.star_border_rounded,
            size: 40,
            color: AppColors.color,
          )));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [...rates],
    );
  }
}
