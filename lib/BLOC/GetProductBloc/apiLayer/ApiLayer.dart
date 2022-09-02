import 'dart:convert';
import 'package:flutter_tst/BLOC/GetProductBloc/apiLayer/api_data_model.dart';
import 'package:flutter_tst/BLOC/productBloc/ApiLayer/api_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tst/utils/host.dart';

class ProductRequestFailure implements Exception {}

class ProductNotFoundFailure implements Exception {}

class DuplicateProductFailure implements Exception {}

class ProductNotInsertedFailure implements Exception {}

class ProductApiClient {
  Future<ProductDataModel> getProducts(offset, length, sortKey) async {
    var url = Uri.parse(
        'http://${port.portnumber}:3000/product//getbypagination?offset=$offset&length=$length&sortKey=$sortKey');
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw ProductRequestFailure();
    }
    final decodedjsonresponse = jsonDecode(response.body)['products'];
    List<ApiModel> products = [];
    for (var ProductJson in decodedjsonresponse) {
      Map<String, int> v = {};
      List<String> images = List.from(ProductJson['images']);
      List<Map<String, String>> videos = [];
      for (var element in ProductJson['videos']) {
        Map<String, String> parseVid = {};
        parseVid['thumbnail_image'] = element['thumbnail_image'];
        parseVid['video'] = element['video'];
        videos.add(parseVid);
      }
      // print();
      for (var entry in ProductJson['attributesValues'].entries) {
        v[entry.key] = entry.value;
      }
      ProductJson['attributesValues'] = v;
      ProductJson['images'] = images;
      ProductJson['videos'] = videos;
      ApiModel got = ApiModel.fromJson(ProductJson);
      products.add(got);
    }
    return ProductDataModel(products: products);
  }

  // Future<ProductDataModel> searchCategories(String query) async {
  //   var url = Uri.parse(
  //       'http://${port.portnumber}:3000/Product/searchProduct?searchstr=$query');
  //   final response = await http.get(url);
  //   if (response.statusCode != 200) {
  //     throw ProductRequestFailure();
  //   }
  //   final decodedjsonresponse = jsonDecode(response.body);
  //   List<Product> categories = [];
  //   for (var ProductJson in decodedjsonresponse) {
  //     categories.add(Product.fromJson(ProductJson));
  //   }
  //   return ProductDataModel(categories: categories);
  // }

  // Future<ProductDataModel> insertProduct(String ProductName) async {
  //   var url = Uri.parse('http://${port.portnumber}:3000/Product/addProduct');
  //   final response = await http.post(url,
  //       headers: {
  //         'Content-Type': 'application/json; charset=UTF-8',
  //       },
  //       body: jsonEncode({"Productname": ProductName}));
  //   if (response.statusCode == 409) {
  //     throw DuplicateProductFailure();
  //   } else if (response.statusCode != 200) {
  //     throw ProductNotInsertedFailure();
  //   } else {
  //     dynamic insertedProduct = jsonDecode(response.body);
  //     insertedProduct = Product.fromJson(insertedProduct[0]);
  //     List<Product> Productdata = [];
  //     Productdata.add(insertedProduct);
  //     return ProductDataModel(categories: Productdata);
  //   }
  // }
}
