// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/dropdown.dart';
import 'package:flutter_tst/utils/colors.dart';

class FilterWidget extends StatefulWidget {
  VoidCallback onOk;
  FilterWidget({Key? key, required this.onOk}) : super(key: key);

  @override
  _FilterWidgetState createState() => _FilterWidgetState();
}

class _FilterWidgetState extends State<FilterWidget> {
  RangeValues _currentRangeValues = const RangeValues(200, 800);
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(0.4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.base_background_begin,
                        AppColors.base_background_end
                      ])),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Text(
                      "Filter Price (Select Range)",
                      style: TextStyle(
                          color: AppColors.color, fontWeight: FontWeight.bold),
                    ),
                    RangeSlider(
                      activeColor: AppColors.color,
                      inactiveColor: AppColors.base_background_end,
                      values: _currentRangeValues,
                      min: 1,
                      max: 10000,
                      onChanged: (RangeValues values) {
                        setState(() {
                          _currentRangeValues = values;
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Flexible(
                            child: Text(
                              "From ${_currentRangeValues.start.toInt()}",
                              style: TextStyle(
                                  color: AppColors.color,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Flexible(
                            child: Text(
                              "To ${_currentRangeValues.end.toInt()}",
                              style: TextStyle(
                                  color: AppColors.color,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Filter Sizes (Select From DropDown)",
                        style: TextStyle(
                            color: AppColors.color,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropDown(
                          itemcount: 4,
                          name: "Size",
                          onchanged: (val) {
                            print(val);
                          },
                          values: ["Medium", "Large", "Small", "Very Small"]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Filter Colors (Select From DropDown)",
                        style: TextStyle(
                            color: AppColors.color,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropDown(
                          itemcount: 4,
                          name: "Color",
                          onchanged: (val) {
                            print(val);
                          },
                          values: ["Red", "Green", "Blue", "Brown"]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "If you want Top rated product click on box",
                        style: TextStyle(
                          color: AppColors.color,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Arial",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                              visualDensity: VisualDensity.compact,
                              side: BorderSide(
                                  color: AppColors.fore_background_begin),
                              activeColor: AppColors.color,
                              checkColor: AppColors.fore_background_begin,
                              value: value,
                              onChanged: (val) {
                                setState(() {
                                  value = val!;
                                });
                              }),
                          Text(
                            "Top Rated",
                            style: TextStyle(
                                color: AppColors.color,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        widget.onOk();
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                AppColors.fore_background_begin,
                                AppColors.fore_background_end
                              ])),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 5, bottom: 5),
                            child: Text(
                              "Ok",
                              style: TextStyle(
                                  color: AppColors.color,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
