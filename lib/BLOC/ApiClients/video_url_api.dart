import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_tst/utils/host.dart';

class VideoUrlApi {
  Future<void> uploadVideoUrl(
      int productId, String imgUrl, String vidUrl) async {
    var url = Uri.parse('http://${port.portnumber}:3000/videourl/addvideourl');
    try {
      await http.post(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({
            "imageUrl": imgUrl,
            "productId": productId,
            "videoUrl": vidUrl
          }));
    } catch (e) {
      rethrow;
    }
  }
}
