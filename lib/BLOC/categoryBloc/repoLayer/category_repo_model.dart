import 'package:flutter_tst/BLOC/categoryBloc/ApiLayer/category_model.dart';

class CategoryRepoModel {
  List<Category> categories;
  CategoryRepoModel({required this.categories});
  factory CategoryRepoModel.fromJson(json) {
    return CategoryRepoModel(categories: json['categories']);
  }
  Map toJson(CategoryRepoModel data) => {'categories': data.categories};
}
