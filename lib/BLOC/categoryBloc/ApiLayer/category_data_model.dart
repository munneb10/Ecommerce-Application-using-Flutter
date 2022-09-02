import 'package:flutter_tst/BLOC/categoryBloc/ApiLayer/category_model.dart';

class CategoryDataModel {
  List<Category> categories;
  CategoryDataModel({required this.categories});
  factory CategoryDataModel.fromJson(json) {
    return CategoryDataModel(categories: json['categories']);
  }
  Map toJson(CategoryDataModel data) => {'categories': data.categories};
}
