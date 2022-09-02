// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_tst/Widgets/Video_widgets/thumb_nail.dart';
import 'package:video_player/video_player.dart';

class ThumbNailVideoPlayer extends StatefulWidget {
  String thumbnailUrl;
  String videoUrl;

  ThumbNailVideoPlayer({
    Key? key,
    required this.thumbnailUrl,
    required this.videoUrl,
  }) : super(key: key);

  @override
  _ThumbNailVideoPlayerState createState() => _ThumbNailVideoPlayerState();
}

class _ThumbNailVideoPlayerState extends State<ThumbNailVideoPlayer> {
  late VideoPlayerController videoControl;
  @override
  Widget build(BuildContext context) {
    return ThumbNailImage(
        thumbnailUrl: widget.thumbnailUrl, vidUrl: widget.videoUrl);
  }
}
