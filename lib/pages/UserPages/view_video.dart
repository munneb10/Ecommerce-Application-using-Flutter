import 'package:flutter/material.dart';
import 'package:flutter_tst/Widgets/Video_widgets/video_player.dart';

class VideoView extends StatefulWidget {
  late String url;
  VideoView({Key? key, required this.url}) : super(key: key);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  @override
  Widget build(BuildContext context) {
    return videoplayer(videoUrl: widget.url);
  }
}
