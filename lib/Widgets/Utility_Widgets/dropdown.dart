// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_tst/utils/colors.dart';

class DropDown extends StatefulWidget {
  int itemcount = 0;
  String name = "drop";
  ValueChanged<String> onchanged;
  BuildContext? cont;
  List values;
  DropDown(
      {Key? key,
      required this.itemcount,
      required this.name,
      required this.onchanged,
      required this.values,
      this.cont})
      : super(key: key);
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  final layerlink = LayerLink();
  late String val;
  late GlobalKey actionKey;
  late double width, height, xposition, yposition;
  late OverlayEntry floatingdropdown;
  late List<Widget> list = [];
  bool isDropDown = false;
  @override
  void initState() {
    val = widget.name;
    list = [];
    for (int i = 0; i < widget.itemcount; i++) {
      list.add(InkWell(
        onTap: () {
          floatingdropdown.remove();
          isDropDown = !isDropDown;
          widget.onchanged(widget.values[i]);
          setState(() {
            val = widget.values[i];
          });
        },
        child: SizedBox(
            height: 50,
            child: Center(
              child: Text(
                widget.values[i][0].toUpperCase() +
                    widget.values[i].substring(1),
                style: TextStyle(fontSize: 18, color: AppColors.color),
              ),
            )),
      ));
    }
    actionKey = LabeledGlobalKey(widget.name);
    super.initState();
  }

  @override
  void dispose() {
    if (isDropDown) {
      floatingdropdown.remove();
    }
    super.dispose();
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(builder: (context) {
      return Stack(children: [
        Positioned(
            width: width,
            child: CompositedTransformFollower(
              offset: Offset(0, -130),
              link: layerlink,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Material(
                  child: Container(
                      height: 126,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                            AppColors.fore_background_begin,
                            AppColors.fore_background_end
                          ])),
                      child: SingleChildScrollView(
                        child: Column(
                          children: list,
                        ),
                      )),
                ),
              ),
            )),
      ]);
    });
  }

  void FindMainDropDownData() {
    RenderBox? rdata =
        actionKey.currentContext?.findRenderObject() as RenderBox?;
    height = rdata?.size.height as double;
    width = rdata?.size.width as double;
    Offset offset = rdata!.localToGlobal(Offset.zero);
    xposition = offset.dx;
    yposition = offset.dy;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: actionKey,
      onTap: () {
        if (isDropDown == false) {
          FindMainDropDownData();
          floatingdropdown = _createOverlayEntry();
          Overlay.of(context)?.insert(floatingdropdown);
        } else {
          floatingdropdown.remove();
        }
        isDropDown = !isDropDown;
      },
      child: CompositedTransformTarget(
        link: layerlink,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            // width: 200,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  AppColors.fore_background_begin,
                  AppColors.fore_background_end
                ])),
            child: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    (val.isNotEmpty ? val[0].toUpperCase() : "") +
                        (val.isNotEmpty ? val.substring(1) : ""),
                    style: TextStyle(
                        color: AppColors.color,
                        fontSize: 25,
                        fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.arrow_drop_down_rounded,
                    color: AppColors.color,
                    size: 50,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
