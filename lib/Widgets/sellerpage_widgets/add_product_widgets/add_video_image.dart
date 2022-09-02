// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/button.dart';
import 'package:flutter_tst/utils/colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:video_player/video_player.dart';

class AddVideoImage extends StatefulWidget {
  ValueChanged onAdd;
  AddVideoImage({Key? key, required this.onAdd}) : super(key: key);

  @override
  _AddVideoImageState createState() => _AddVideoImageState();
}

class _AddVideoImageState extends State<AddVideoImage> {
  bool toShowMessage = false;
  String errorMessage = "";
  bool doneImage = false;
  bool isShowVideo = false;
  bool isPlaying = false;
  late File thumbnailImageData;
  List imgExt = ["png", "jpg", "jpeg", "JPEG", "tiff", "gif"];
  late File videoData;
  late VideoPlayerController _controller;
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
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
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MediaQuery.of(context).viewInsets.bottom == 0
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
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
                          doneImage == true
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Stack(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (_) => PhotoView(
                                                      imageProvider: FileImage(
                                                          thumbnailImageData))));
                                        },
                                        child: Image(
                                          width: 180,
                                          height: 205,
                                          fit: BoxFit.fill,
                                          image: FileImage(thumbnailImageData),
                                        ),
                                      ),
                                      GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              doneImage = false;
                                              // thumbnailImageData = null as File;
                                              // print(thumbnailImageData);
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 0, left: 12),
                                            child: Icon(
                                              Icons.cancel,
                                              color: AppColors.color,
                                              size: 40,
                                            ),
                                          ))
                                    ],
                                  ),
                                )
                              : Container(),
                          SizedBox(
                            height: 20,
                          ),
                          Button(
                              buttonValue: "Add ThumbNail Image",
                              onclick: () async {
                                final ImagePicker _picker = ImagePicker();
                                XFile? image = (await _picker.pickImage(
                                    source: ImageSource.gallery));
                                if (image?.path == null) return;
                                File imgFile = File(image!.path);
                                setState(() {
                                  thumbnailImageData = imgFile;
                                  doneImage = true;
                                });
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          isShowVideo == true
                              ? _controller.value.isInitialized
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(20),
                                      child: SizedBox(
                                          width: 250,
                                          height: 250,
                                          child: getVideoPlayer()),
                                    )
                                  : Container()
                              : Container(),
                          SizedBox(
                            height: 20,
                          ),
                          Button(
                              buttonValue: "Add Video",
                              onclick: () async {
                                final ImagePicker _picker = ImagePicker();
                                XFile? video = await _picker.pickVideo(
                                    source: ImageSource.gallery,
                                    maxDuration: Duration(seconds: 30));
                                if (video?.path == null) return;
                                List pathSplited =
                                    video?.path.split("/") as List;

                                String selectedFileExtension =
                                    pathSplited.last.split(".").last;
                                if (imgExt.contains(selectedFileExtension)) {}
                                videoData = File(video!.path);
                                _controller =
                                    VideoPlayerController.file(videoData)
                                      ..initialize().then((_) {
                                        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                                        setState(() {});
                                      });
                                setState(() {
                                  isShowVideo = true;
                                });
                              }),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Button(
                                  buttonValue: "Ok",
                                  onclick: () {
                                    // widget.onRemove(widget.attributes_data);
                                    if (doneImage == false) {
                                      setState(() {
                                        toShowMessage = true;
                                        errorMessage =
                                            "Please Add ThumbNail Image (Click on [Add ThumbNail Image] to Add Image";
                                      });
                                    } else if (isShowVideo == false) {
                                      setState(() {
                                        toShowMessage = true;
                                        errorMessage =
                                            "Please Add Video (Click on [Add Video] to add video";
                                      });
                                    } else {
                                      Map<String, File> videoImage = {};
                                      videoImage["image"] = thumbnailImageData;
                                      videoImage["video"] = videoData;
                                      widget.onAdd(videoImage);
                                    }
                                  }),
                              Button(
                                  buttonValue: "Cancel",
                                  onclick: () {
                                    // widget.onCancel();
                                  }),
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

  Widget getVideoPlayer() {
    return Stack(
      alignment: Alignment.center,
      children: [
        GestureDetector(
            onTap: () {
              setState(() {
                isPlaying = false;
                _controller.pause();
              });
            },
            child: VideoPlayer(_controller)),
        isPlaying == false
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    isPlaying = !isPlaying;
                    _controller.play();
                  });
                },
                child: Icon(
                  Icons.play_arrow,
                  color: AppColors.color,
                  size: 70,
                ),
              )
            : Container(),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _controller.dispose();
                  isShowVideo = false;
                  isPlaying = false;
                });
              },
              child: Icon(
                Icons.cancel,
                color: AppColors.color,
                size: 25,
              ),
            ),
          ),
        )
      ],
    );
  }
}
