// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_tst/BLOC/AllProductBloc/blocLayer/all_product_bloc.dart';
import 'package:flutter_tst/BLOC/AllProductBloc/blocLayer/all_product_state.dart';
import 'package:flutter_tst/BLOC/productBloc/blocLayer/blocModel.dart';
import 'package:flutter_tst/FileData/upload_file_model.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/menu/menu.dart';
import 'package:flutter_tst/utils/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UploadingProducts extends StatelessWidget {
  const UploadingProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                AppColors.base_background_begin,
                AppColors.base_background_end
              ])),
          child: Column(
            children: [
              SizedBox(
                height: 15,
              ),
              AppMenu(
                menu: true,
                home: true,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Uploading Product",
                style: TextStyle(
                    color: AppColors.color,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              BlocBuilder<AllProductBloc, AllProductState>(
                  builder: (context, state) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: state.uploadingProducts.length,
                      itemBuilder: (context, index) {
                        return UplodingWidget(
                          product: state.uploadingProducts[index],
                        );
                      }),
                );
              }),
              SizedBox(
                height: 30,
              ),
              Text(
                "Uploaded Product",
                style: TextStyle(
                    color: AppColors.color,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UplodingWidget extends StatefulWidget {
  final blocModel product;
  const UplodingWidget({Key? key, required this.product}) : super(key: key);

  @override
  State<UplodingWidget> createState() => _UplodingWidgetState();
}

class _UplodingWidgetState extends State<UplodingWidget> {
  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.fore_background_begin,
                  AppColors.fore_background_end
                ])),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  widget.product.title
                      .padRight(widget.product.title.length - 7),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: AppColors.color, fontSize: 20),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isOpen = !isOpen;
                    });
                  },
                  child: Icon(
                    Icons.arrow_drop_down_rounded,
                    color: AppColors.color,
                    size: 40,
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            isOpen
                ? Column(
                    children: [
                      Text(
                        "Uploading Images",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.color, fontSize: 15),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.product.getImages().length,
                            itemBuilder: (context, index) {
                              UploadFileModel image =
                                  widget.product.getImageByIndex(index);
                              return Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Image(
                                          fit: BoxFit.fill,
                                          height: 100,
                                          image: FileImage(image.file)),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 8,
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            child: LinearProgressIndicator(
                                                backgroundColor:
                                                    Colors.lightBlueAccent,
                                                color: Colors.red,
                                                minHeight: 15,
                                                value: (image.totalUploaded /
                                                            image.totalSize)
                                                        .isNaN
                                                    ? 0.01
                                                    : (image.totalUploaded /
                                                        image.totalSize)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 1,
                        color: Colors.grey,
                        margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Uploading Videos",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: AppColors.color, fontSize: 15),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 250,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: widget.product.getVideos().length,
                            itemBuilder: (context, index) {
                              Map<String, UploadFileModel> video =
                                  widget.product.getVideoByIndex(index);
                              double progress = (video['video']!.totalUploaded /
                                  video['video']!.totalSize);
                              if (progress.isNaN) {
                                progress = 0.001;
                              }
                              // print(
                              //     "(${video['video']!.totalUploaded} ${video['video']!.totalSize})");
                              return Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2, // 60% of space => (6/(6 + 4))
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Image(
                                          fit: BoxFit.fill,
                                          height: 100,
                                          image:
                                              FileImage(video['image']!.file)),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 8, // 40% of space
                                    child: Padding(
                                      padding: const EdgeInsets.all(4.0),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            child: LinearProgressIndicator(
                                              backgroundColor:
                                                  Colors.lightBlueAccent,
                                              color: Colors.red,
                                              minHeight: 15,
                                              value: progress,
                                            ),
                                          ),
                                          // Padding(
                                          //   padding:
                                          //       const EdgeInsets.only(top: 10),
                                          //   child: SizedBox(
                                          //     child: LinearProgressIndicator(
                                          //       backgroundColor:
                                          //           Colors.lightBlueAccent,
                                          //       color: Colors.red,
                                          //       minHeight: 15,
                                          //       value: ((video['video']!
                                          //                       .totalUploaded /
                                          //                   video['video']!
                                          //                       .totalSize) *
                                          //               100) /
                                          //           100,
                                          //     ),
                                          //   ),
                                          // )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      )
                    ],
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
