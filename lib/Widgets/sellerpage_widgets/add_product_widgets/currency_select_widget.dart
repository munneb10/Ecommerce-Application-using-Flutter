// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, unused_local_variable, must_be_immutable, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_tst/utils/country_data.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/textinput.dart';
import 'package:flutter_tst/utils/colors.dart';

double globalxposition = 0;
double globalyposition = 0;

class SearchDropDown extends StatefulWidget {
  List<dynamic> values;
  List<dynamic>? altclickvalues;
  ValueChanged? onaltchange;
  String name;
  String searchfieldname;
  int itemcount = FlagImages.flagsImages.length;
  ValueChanged<dynamic> onchanged;
  SearchDropDown(this.name,
      {Key? key,
      required this.onchanged,
      required this.values,
      this.altclickvalues,
      this.onaltchange,
      required this.searchfieldname})
      : super(key: key);
  @override
  _SearchDropDownState createState() => _SearchDropDownState();
}

class _SearchDropDownState extends State<SearchDropDown> {
  final layerlink = LayerLink();
  String vals = "";
  late dynamic val = "";
  late GlobalKey actionKey;
  late double width, height, xposition, yposition;
  late OverlayEntry floatingdropdown;
  bool isDropDown = false;

  @override
  void initState() {
    val = widget.name;
    actionKey = LabeledGlobalKey(widget.name);
    super.initState();
  }

  OverlayEntry _createOverlayEntry() {
    return OverlayEntry(builder: (context) {
      return SearchListCountry(
        searchboxval: widget.searchfieldname,
        values: widget.values,
        width: width,
        onchange: (val) {
          setState(() {
            floatingdropdown.remove();
            isDropDown = !isDropDown;
            widget.onchanged(val);
            this.val = val;
          });
        },
        altchangevalues: widget.altclickvalues,
        onaltchange: widget.onaltchange,
        layerlink: layerlink,
      );
    });
  }

  void findMainDropDownData() {
    RenderBox? rdata =
        actionKey.currentContext?.findRenderObject() as RenderBox?;
    height = rdata?.size.height as double;
    width = rdata?.size.width as double;
    Offset offset = rdata!.localToGlobal(Offset.zero);
    xposition = offset.dx;
    yposition = offset.dy;
    globalxposition = xposition;
    globalyposition = yposition;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: actionKey,
      onTap: () {
        if (isDropDown == false) {
          findMainDropDownData();
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
                  Flexible(
                    child: Text(
                      (val.length > 0 ? val[0].toUpperCase() : "") +
                          (val.length > 0 ? val.substring(1) : ""),
                      style: TextStyle(
                          color: AppColors.color,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
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

class SearchListCountry extends StatefulWidget {
  double width;
  ValueChanged onchange;
  ValueChanged? onaltchange;
  final layerlink;
  List<dynamic> values;
  List<dynamic>? altchangevalues;
  String searchboxval;
  SearchListCountry(
      {Key? key,
      required this.width,
      required this.onchange,
      required this.layerlink,
      required this.values,
      this.altchangevalues,
      this.onaltchange,
      required this.searchboxval})
      : super(key: key);

  @override
  _SearchListCountryState createState() => _SearchListCountryState();
}

class _SearchListCountryState extends State<SearchListCountry> {
  List widgetData = [];
  List widgetDataBackup = [];
  List altData = [];
  List altBackupData = [];
  List values = [];

  @override
  void initState() {
    values = widget.values;
    widgetData.addAll(values);
    if (widget.altchangevalues != null) {
      for (var i = 0; i < widget.altchangevalues!.length; i++) {
        altData.add(widget.altchangevalues![i]);
      }
      altBackupData.addAll(altData);
    }
    widgetDataBackup.addAll(widgetData);
    setDropDwonData();
    super.initState();
  }

  List list = [];
  void setDropDwonData() {
    list = [];
    for (int i = 0; i < widgetData.length; i++) {
      list.add(InkWell(
        onTap: () {
          widget.onchange(widgetData[i]);
          if (widget.onaltchange != null && widget.altchangevalues != null) {
            widget.onaltchange!(altData[i]);
          }
        },
        child: SizedBox(
            height: 50,
            child: Center(
              child: Text(widgetData[i],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.color,
                  )),
            )),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Positioned(
          width: widget.width,
          child: CompositedTransformFollower(
            offset: Offset(0, -180),
            link: widget.layerlink,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Material(
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                        AppColors.fore_background_begin,
                        AppColors.fore_background_end
                      ])),
                  child: Column(
                    children: [
                      Container(
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
                              children: [
                                ...list,
                              ],
                            ),
                          )),
                      TextInput(
                        textfieldvalue: widget.searchboxval,
                        onchange: (valuee) {
                          setState(() {
                            widgetData.clear();
                            if (widget.altchangevalues != null) {
                              altData.clear();
                            }
                            for (int i = 0; i < widgetDataBackup.length; i++) {
                              if (widgetDataBackup[i]
                                  .toLowerCase()
                                  .startsWith(valuee.toLowerCase())) {
                                widgetData.add(widgetDataBackup[i]);
                                if (widget.altchangevalues != null) {
                                  altData.add(altBackupData[i]);
                                }
                              }
                            }

                            setDropDwonData();
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
    ]);
  }
}
