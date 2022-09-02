// ignore_for_file: prefer_const_constructors, camel_case_types, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tst/utils/colors.dart';
import 'package:video_player/video_player.dart';

class videoplayer extends StatefulWidget {
  String videoUrl;
  videoplayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _videoplayerState createState() => _videoplayerState();
}

class _videoplayerState extends State<videoplayer> {
  late VideoPlayerController _controller;
  bool isplaying = true;
  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..addListener(() => setState(() {}))
      ..setLooping(true)
      ..initialize().then((value) {
        _controller.play();
      });
    super.initState();
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: OrientationBuilder(builder: (context, orientation) {
        return Column(
          children: [
            Stack(
              children: [
                GestureDetector(
                  onTap: () {
                    if (isplaying == true) {
                      setState(() {
                        _controller.pause();
                      });
                    } else {
                      setState(() {
                        _controller.play();
                      });
                    }

                    isplaying = !isplaying;
                  },
                  // Loading Video to show will ready othervise show circular bar indicator
                  child: SizedBox(
                      height: (orientation == Orientation.portrait
                          ? 200
                          : MediaQuery.of(context).size.height - 50),
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        child: _controller.value.isInitialized
                            ? VideoPlayer(_controller)
                            : Center(child: CircularProgressIndicator()),
                      )),
                ),
                // if not playing then show pause button to play again othervise nothing
                isplaying == false
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: orientation == Orientation.portrait
                            ? 200
                            : MediaQuery.of(context).size.height - 50,
                        child: GestureDetector(
                          onTap: () => setState(() {
                            _controller.play();
                            isplaying = true;
                          }),
                          child: Center(
                            child: Icon(
                              Icons.play_arrow,
                              color: AppColors.color,
                              size: 80,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                // if video buffering then show circular bar indicator othervise nothing
                _controller.value.isBuffering
                    ? SizedBox(
                        height: orientation == Orientation.portrait
                            ? 200
                            : MediaQuery.of(context).size.height - 50,
                        child: Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              color: AppColors.color,
                            )))
                    : Container(),
                // if orientation is portrait then show full screen icon on right bottom otherwise show small screen icon on right bottom
                orientation == Orientation.portrait
                    ? SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: orientation == Orientation.portrait
                            ? 200
                            : MediaQuery.of(context).size.height - 50,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              SystemChrome.setPreferredOrientations([
                                DeviceOrientation.landscapeLeft,
                                DeviceOrientation.landscapeRight,
                              ]);
                            },
                            child: Icon(
                              Icons.fullscreen,
                              color: AppColors.color,
                              size: 50,
                            ),
                          ),
                        ),
                      )
                    : SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: orientation == Orientation.portrait
                            ? 200
                            : MediaQuery.of(context).size.height - 50,
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: GestureDetector(
                            onTap: () {
                              SystemChrome.setPreferredOrientations([
                                DeviceOrientation.portraitDown,
                                DeviceOrientation.portraitUp,
                              ]);
                            },
                            child: Icon(
                              Icons.fullscreen_exit,
                              color: AppColors.color,
                              size: 50,
                            ),
                          ),
                        ),
                      )
              ],
            ),
            // Build Indicator that will help to change the position of video
            SizedBox(
              height: 12,
              child: buildIndicator(),
            ),
          ],
        );
      }),
    );
  }

// connecting it with video controller to enable it
  buildIndicator() {
    return VideoProgressIndicator(
      _controller,
      allowScrubbing: true,
      colors: VideoProgressColors(
          bufferedColor: AppColors.color,
          playedColor: AppColors.fore_background_begin),
    );
  }
}
