// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_tst/BLOC/productBloc/ApiLayer/api_model.dart';
import 'package:flutter_tst/Widgets/Video_widgets/thumb_nail_video.dart';
import 'package:flutter_tst/utils/colors.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter_tst/utils/host.dart';

class VideosPreview extends StatefulWidget {
  ApiModel product;
  VideosPreview({Key? key, required this.product}) : super(key: key);

  @override
  VvideosStatePreview createState() => VvideosStatePreview();
}

class VvideosStatePreview extends State<VideosPreview> {
  VideoPlayerController? isanyplaying;
  @override
  void initState() {
    super.initState();
  }

  List<Widget> get_video() {
    List<Widget> videos = [];
    for (Map<String, String> product in widget.product.videosLink) {
      videos.add(Padding(
        padding: const EdgeInsets.all(5.0),
        child: ThumbNailVideoPlayer(
          thumbnailUrl:
              'http://${port.portnumber}:3000/static/uploads/${product['thumbnail_image']}',
          videoUrl:
              'http://${port.portnumber}:3000/static/uploads/${product['video']}',
        ),
      ));
    }
    return videos;
  }

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [...get_video()],
            ),
          ),
        ),
      ),
    ));
  }
}
