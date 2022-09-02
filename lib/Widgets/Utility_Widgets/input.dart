// ignore_for_file: prefer_const_constructors, camel_case_types, must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter_tst/utils/colors.dart';

class Input_box extends StatefulWidget {
  VoidCallback? onFilter;
  ValueChanged? onSearch;
  TextInputType? keyType;
  String? textfieldvalue;
  bool? issearch = false;
  ValueChanged? onchange;
  VoidCallback? ontap;
  bool? isfilter = false;
  String? val;
  Input_box(
      {Key? key,
      required this.textfieldvalue,
      this.onchange,
      this.onFilter,
      this.onSearch,
      this.isfilter,
      this.issearch,
      this.ontap,
      this.val,
      this.keyType})
      : super(key: key);

  @override
  State<Input_box> createState() => _Input_boxState();
}

class _Input_boxState extends State<Input_box> {
  @override
  Widget build(BuildContext context) {
    double keyboardCurrentState = MediaQuery.of(context).viewInsets.bottom;
    if (keyboardCurrentState < keyboardstate.prevkeyboardstate) {
      // called when keyboard closed completely
      if (keyboardCurrentState == 0) {
        FocusScope.of(context).unfocus();
      }
    }
    if (keyboardCurrentState > keyboardstate.prevkeyboardstate) {
      if (keyboardstate.lock == false) {
        keyboardstate.lock = true;
        // called when keyboard open

      }
    }
    keyboardstate.prevkeyboardstate = keyboardCurrentState;
    return Form(
      child: Column(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            child: Row(children: [
              Flexible(
                child: TextFormField(
                  initialValue: widget.val ?? "",
                  keyboardType: widget.keyType ?? TextInputType.text,
                  onTap: () {
                    if (widget.ontap != null) {}
                  },
                  cursorHeight: 30,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 30, color: AppColors.color),
                  cursorColor: AppColors.color,
                  cursorWidth: 4.0,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    border: InputBorder.none,
                    hintText: widget.textfieldvalue,
                    isDense: true,
                    hintStyle: TextStyle(
                        color: AppColors.color_lite,
                        fontSize: 20,
                        fontFamily: "Arial",
                        fontWeight: FontWeight.bold),
                  ),
                  onChanged: (value) {
                    if (widget.onchange != null) {
                      widget.onchange!(value);
                    }
                  },
                ),
              ),
              widget.issearch == true
                  ? Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.onSearch!(widget.textfieldvalue);
                          },
                          child: SizedBox(
                            child: Icon(
                              Icons.search,
                              color: AppColors.color,
                              size: 25,
                            ),
                          ),
                        ),
                        Text(
                          "Search",
                          style:
                              TextStyle(color: AppColors.color, fontSize: 10),
                        ),
                      ],
                    )
                  : Container(),
              SizedBox(
                width: 10,
              ),
              widget.isfilter == true
                  ? Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            widget.onFilter!();
                          },
                          child: SizedBox(
                            child: Icon(
                              Icons.tune,
                              color: AppColors.color,
                              size: 25,
                            ),
                          ),
                        ),
                        Text(
                          "Filters",
                          style: TextStyle(
                            color: AppColors.color,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    )
                  : Container()
            ]),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width - 20,
            child: Divider(
              thickness: 1.5,
              color: AppColors.color,
            ),
          )
        ],
      ),
    );
  }
}

class keyboardstate {
  static double prevkeyboardstate = 0;
  static bool lock = false;
}
