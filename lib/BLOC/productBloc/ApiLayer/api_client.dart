import 'dart:convert';

import 'package:flutter_tst/BLOC/productBloc/ApiLayer/api_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tst/utils/host.dart';

class ApiClient {
  void uploadProduct(ApiModel product) async {
    var url = Uri.parse('http://${port.portnumber}:3000/product/addproduct');
    print("At Api");
    print(product.attr);
    try {
      await http.post(url,
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(product.toJson()));
    } catch (e) {
      rethrow;
    }
  }
}
