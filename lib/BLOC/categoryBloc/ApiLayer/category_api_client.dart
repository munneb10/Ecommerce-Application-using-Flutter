import 'dart:convert';
import 'package:flutter_tst/BLOC/categoryBloc/ApiLayer/category_data_model.dart';
import 'package:flutter_tst/BLOC/categoryBloc/ApiLayer/category_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_tst/utils/host.dart';

class CategoryRequestFailure implements Exception {}

class CategoryNotFoundFailure implements Exception {}

class DuplicateCategoryFailure implements Exception {}

class CategoryNotInsertedFailure implements Exception {}

class CategoryApiClient {
  Future<CategoryDataModel> getCategories() async {
    var url = Uri.parse('http://${port.portnumber}:3000/category/');
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw CategoryRequestFailure();
    }
    final decodedjsonresponse = jsonDecode(response.body)['categories'];

    List<Category> categories = [];
    for (var categoryJson in decodedjsonresponse) {
      Category got = Category.fromJson(categoryJson);
      categories.add(got);
    }
    return CategoryDataModel(categories: categories);
  }

  Future<CategoryDataModel> searchCategories(String query) async {
    var url = Uri.parse(
        'http://${port.portnumber}:3000/category/searchcategory?searchstr=$query');
    final response = await http.get(url);
    if (response.statusCode != 200) {
      throw CategoryRequestFailure();
    }
    final decodedjsonresponse = jsonDecode(response.body);
    List<Category> categories = [];
    for (var categoryJson in decodedjsonresponse) {
      categories.add(Category.fromJson(categoryJson));
    }
    return CategoryDataModel(categories: categories);
  }

  Future<CategoryDataModel> insertCategory(String categoryName) async {
    var url = Uri.parse('http://${port.portnumber}:3000/category/addcategory');
    final response = await http.post(url,
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({"categoryname": categoryName}));
    if (response.statusCode == 409) {
      throw DuplicateCategoryFailure();
    } else if (response.statusCode != 200) {
      throw CategoryNotInsertedFailure();
    } else {
      dynamic insertedcategory = jsonDecode(response.body);
      insertedcategory = Category.fromJson(insertedcategory[0]);
      List<Category> categorydata = [];
      categorydata.add(insertedcategory);
      return CategoryDataModel(categories: categorydata);
    }
  }
}
