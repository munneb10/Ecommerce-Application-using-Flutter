import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_tst/utils/host.dart';

class ImageUrlApi {
  Future<void> uploadImageUrl(int productId, String imgUrl) async {
    var url = Uri.parse('http://${port.portnumber}:3000/imageurl/addimageurl');
    try {
      await http.post(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode({"imageUrl": imgUrl, "productId": productId}));
    } catch (e) {
      rethrow;
    }
  }
}
