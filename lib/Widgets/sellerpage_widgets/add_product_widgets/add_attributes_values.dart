// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/input.dart';

import '../../../utils/colors.dart';
import '../../Utility_Widgets/button.dart';

typedef OnAddCallBack = void Function(Map<String, int> val, int quantity);

class AttributeValues extends StatefulWidget {
  Map<String, Map<dynamic, dynamic>> attributes;
  VoidCallback onCancel;
  OnAddCallBack onAdd;
  bool isAvail;
  Map<String, int>? availAttrVal;
  AttributeValues(
      {Key? key,
      required this.attributes,
      required this.onCancel,
      required this.onAdd,
      required this.isAvail,
      this.availAttrVal})
      : super(key: key);

  @override
  State<AttributeValues> createState() => _AttributeValuesState();
}

class _AttributeValuesState extends State<AttributeValues> {
  Map<String, int> attrCombination = {};
  List<Map<String, dynamic>> filterd = [];
  List<Widget> attrValuesWid = [];
  void createCombination(
      List<Map<String, dynamic>> attr, int ind, String tillComb) {
    if (ind == attr.length) {
      attrCombination[tillComb] = -1;
      return;
    }
    for (var element in attr[ind]['values']) {
      createCombination(attr, ind + 1, tillComb + element + "/");
    }
  }

  void createWidget() {
    for (MapEntry attrVal in attrCombination.entries) {
      attrValuesWid.add(Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              attrVal.key,
              style: TextStyle(
                  color: AppColors.color,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          )),
          Expanded(
              child: Input_box(
            val: widget.isAvail ? attrVal.value.toString() : "",
            textfieldvalue: "Quantity",
            keyType: TextInputType.number,
            onchange: (val) {
              if (val == "") {
                attrCombination[attrVal.key] = -1;
              }
              try {
                attrCombination[attrVal.key] = int.parse(val);
              } catch (e) {
                return;
              }
            },
          ))
        ],
      ));
    }
  }

  int findQuan() {
    int q = 0;
    for (var element in attrCombination.entries) {
      q += element.value;
    }
    return q;
  }

  @override
  void initState() {
    if (widget.isAvail != false) {
      attrCombination = widget.availAttrVal!;
      createWidget();
    } else {
      for (MapEntry entry in widget.attributes.entries) {
        filterd.add(entry.value);
      }
      createCombination(filterd, 0, "");
      createWidget();
    }

    super.initState();
  }

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
            child: Stack(children: [
              SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment:
                          MediaQuery.of(context).viewInsets.bottom == 0
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
                                // crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ...attrValuesWid,
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Button(
                                          buttonValue: "Add Values",
                                          onclick: () {
                                            int quan = findQuan();
                                            print(attrCombination);
                                            widget.onAdd(attrCombination, quan);
                                          }),
                                      Button(
                                          buttonValue: "Cancel",
                                          onclick: () {
                                            widget.onCancel();
                                          })
                                    ],
                                  )
                                ])))
                  ]))
            ])));
    ;
  }
}
