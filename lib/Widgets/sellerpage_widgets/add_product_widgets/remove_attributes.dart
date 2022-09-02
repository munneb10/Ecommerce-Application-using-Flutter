// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/button.dart';
import 'package:flutter_tst/utils/colors.dart';

class RemoveAttributeDialog extends StatefulWidget {
  ValueChanged<Map<String, Widget>> onRemove;
  VoidCallback onCancel;
  Map<String, Widget> attributes_data;
  RemoveAttributeDialog(
      {Key? key,
      required this.onRemove,
      required this.attributes_data,
      required this.onCancel})
      : super(key: key);

  @override
  _RemoveAttributeDialogState createState() => _RemoveAttributeDialogState();
}

class _RemoveAttributeDialogState extends State<RemoveAttributeDialog> {
  List<Widget> dropdowns = [];
  void setattributes() {
    dropdowns.clear();
    for (var entry in widget.attributes_data.entries) {
      dropdowns.add(Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: entry.value,
          ),
          Positioned(
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                    onTap: () {
                      setState(() {
                        widget.attributes_data.remove(entry.key);
                        setattributes();
                      });
                    },
                    child: Icon(Icons.cancel_rounded, color: AppColors.color)),
              ))
        ],
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    setattributes();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(0.5),
      child: Column(
        mainAxisAlignment: MediaQuery.of(context).viewInsets.bottom == 0
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 20,
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...dropdowns,
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Button(
                          buttonValue: "Ok",
                          onclick: () {
                            widget.onRemove(widget.attributes_data);
                          }),
                      Button(
                          buttonValue: "Cancel",
                          onclick: () {
                            widget.onCancel();
                          }),
                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
