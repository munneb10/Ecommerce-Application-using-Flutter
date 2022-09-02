// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_tst/utils/colors.dart';

class ThumbNailImage extends StatefulWidget {
  late String thumbnailUrl;
  late String vidUrl;
  ThumbNailImage({Key? key, required this.thumbnailUrl, required this.vidUrl})
      : super(key: key);
  @override
  TthumbStateNailImage createState() => TthumbStateNailImage();
}

class TthumbStateNailImage extends State<ThumbNailImage> {
  // function to load thumb nail image and this is future buildder when image will load it will set the sate again
  Future<Widget> getImage(String imgUrl) async {
    //stack widget with the image and the play button on the tap
    return Stack(children: [
      GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, '/view_video',
              arguments: {'url': widget.vidUrl});
        },
        child: Stack(
          children: [
            Image(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
              image: NetworkImage(imgUrl),
              fit: BoxFit.fill,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.width / 2,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.play_arrow,
                    size: 70,
                    color: AppColors.color,
                  ),
                ],
              ),
            )
          ],
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.width / 2,
          child: Center(
              child: Text(
            "Loading...",
            style: TextStyle(color: AppColors.color, fontSize: 20),
          )),
        ),
        // This will show when the image will load
        FutureBuilder(
            future: getImage(widget.thumbnailUrl),
            builder: (BuildContext context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                } else if (snapshot.hasData) {
                  final data = snapshot.data as Widget;
                  return data;
                }
              }
              return Center(
                  child: Text(
                "Loading...",
                style: TextStyle(color: AppColors.color),
              ));
            }),
      ],
    );
  }
}
