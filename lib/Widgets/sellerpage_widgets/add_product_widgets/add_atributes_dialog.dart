// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/button.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/dropdown.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/input.dart';
import 'package:flutter_tst/utils/colors.dart';

class AddAttributesDialog extends StatefulWidget {
  ValueChanged<Map<dynamic, dynamic>> onAdd;
  VoidCallback onCancel;
  AddAttributesDialog({Key? key, required this.onAdd, required this.onCancel})
      : super(key: key);

  @override
  _AddAttributesDialogState createState() => _AddAttributesDialogState();
}

class _AddAttributesDialogState extends State<AddAttributesDialog> {
  List<String> attrValues = [];
  String atributeName = "";
  String newValue = "";
  Map<String, Widget> valuesIdentifier = {};
  List<Widget> addedValues = [];
  String errorMessage = "This is error message";
  bool toShowMessage = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height -
          MediaQuery.of(context).viewInsets.bottom -
          24,
      color: Colors.black.withOpacity(0.5),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MediaQuery.of(context).viewInsets.bottom == 0
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  Container(
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
                            "Attribute means what are the types of your product available means your product can have sizes and colors so you can add that color and sizes here \nStep 1) Add your product Type(e.g Size) \nStep 2) Add the available types value (e.g large,small,medium)",
                            style: TextStyle(
                                color: AppColors.color,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Input_box(
                              textfieldvalue: "Attribute Name",
                              onchange: (value) {
                                setState(() {
                                  atributeName = value;
                                });
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          Input_box(
                              textfieldvalue: "Attribute Values",
                              onchange: (value) {
                                setState(() {
                                  newValue = value;
                                });
                              }),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "click on the value if you want to remove : ",
                            style: TextStyle(
                                color: AppColors.color,
                                fontSize: 10,
                                fontWeight: FontWeight.bold),
                          ),
                          Wrap(
                              direction: Axis.horizontal,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              spacing: 10,
                              children: [
                                Text(
                                  "Values : ",
                                  style: TextStyle(
                                      color: AppColors.color,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                ...addedValues
                              ]),
                          SizedBox(
                            height: 10,
                          ),
                          Button(
                              buttonValue: "Add value",
                              onclick: () {
                                if (newValue.isNotEmpty &&
                                    attrValues.contains(newValue) == false) {
                                  String toRemove = newValue;
                                  FocusScopeNode currentFocus =
                                      FocusScope.of(context);
                                  if (!currentFocus.hasPrimaryFocus) {
                                    currentFocus.unfocus();
                                  }
                                  setState(() {
                                    // created the value widget to add and after that adding in the attr_value to show in the dropdownbox addedValues to show in row in the valuesIdentifier to identify widget
                                    Widget toAdd = Button(
                                        buttonValue: newValue,
                                        onclick: () {
                                          // first removing from value identifier map and then clearing the widget list and then after removind from value identifier or clearing added values adding the remaining values left in values identifier after that setting state
                                          valuesIdentifier.remove(toRemove);
                                          addedValues.clear();
                                          attrValues.remove(toRemove);
                                          for (var entry
                                              in valuesIdentifier.entries) {
                                            addedValues.add(entry.value);
                                          }
                                          setState(() {});
                                        });
                                    attrValues.add(newValue);
                                    addedValues.add(toAdd);
                                    valuesIdentifier[newValue] = toAdd;
                                    newValue = "";
                                  });
                                }
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Your attribute is like",
                            style: TextStyle(
                                color: AppColors.color,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          DropDown(
                              key: UniqueKey(),
                              itemcount: attrValues.length,
                              name: atributeName,
                              onchanged: (value) {},
                              values: attrValues),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Click on it if your attribute is done",
                            style: TextStyle(
                                color: AppColors.color,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Button(
                                  buttonValue: "Add Attribute",
                                  onclick: () {
                                    if (atributeName.isEmpty) {
                                      errorMessage =
                                          "Please enter product type value";
                                      setState(() {
                                        toShowMessage = true;
                                      });
                                    } else if (attrValues.isEmpty) {
                                      errorMessage =
                                          "Please enter product type value";
                                      setState(() {
                                        toShowMessage = true;
                                      });
                                    } else {
                                      Map<String, dynamic> val = {};
                                      val['name'] = atributeName;
                                      val['values'] = attrValues;
                                      widget.onAdd(val);
                                    }
                                  }),
                              Button(
                                  buttonValue: "Cancel",
                                  onclick: () {
                                    widget.onCancel();
                                  })
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            toShowMessage == true
                ? Stack(
                    children: [
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Container(
                          width: MediaQuery.of(context).size.width - 20,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    AppColors.fore_background_begin,
                                    AppColors.fore_background_end
                                  ])),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              errorMessage,
                              style: TextStyle(
                                  color: AppColors.color,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          right: 0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  toShowMessage = false;
                                });
                              },
                              child: Icon(
                                Icons.cancel_rounded,
                                color: AppColors.color,
                              ),
                            ),
                          ))
                    ],
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
