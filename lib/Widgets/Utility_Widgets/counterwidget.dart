// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_tst/utils/colors.dart';

class CounterWidget extends StatefulWidget {
  ValueSetter<int> onChanged;
  int limit;
  int initialValue;
  CounterWidget(
      {Key? key,
      required this.onChanged,
      required this.limit,
      required this.initialValue})
      : super(key: key);

  @override
  _CounterWidgetState createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  @override
  void initState() {
    // TODO: implement initState
    print("state changes");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          child: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), bottomLeft: Radius.circular(15)),
            child: Container(
              height: 45,
              width: 45,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    AppColors.fore_background_begin,
                    AppColors.fore_background_end
                  ])),
              child: Text(
                "-",
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: AppColors.color),
              ),
            ),
          ),
          onTap: () {
            if (widget.initialValue > 0) {
              widget.initialValue--;
              widget.onChanged(widget.initialValue);
            }
          },
        ),
        Container(
          height: 45,
          width: 60,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                AppColors.fore_background_begin,
                AppColors.fore_background_end
              ])),
          child: Text(
            "${widget.initialValue}",
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: AppColors.color),
          ),
        ),
        InkWell(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15)),
              child: Container(
                height: 45,
                width: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      AppColors.fore_background_begin,
                      AppColors.fore_background_end
                    ])),
                child: Text(
                  "+",
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: AppColors.color),
                ),
              ),
            ),
            onTap: () {
              if (widget.initialValue < widget.limit) {
                widget.initialValue++;
                widget.onChanged(widget.initialValue);
              }
            })
      ],
    );
  }
}
