import 'package:flutter_tst/BLOC/categoryBloc/ApiLayer/category_model.dart';
import 'package:flutter_tst/BLOC/categoryBloc/repoLayer/category_repo_model.dart';

class CategoryLogicModel {
  List<Category> categories;
  DateTime lastupdated;
  CategoryLogicModel({required this.categories, required this.lastupdated});
  factory CategoryLogicModel.fromJson(json) {
    return CategoryLogicModel(
        categories: json['categories'], lastupdated: json['lastupdated']);
  }
  static final empty =
      CategoryLogicModel(categories: [], lastupdated: DateTime(0));
  Map toJson() => {'categories': categories, 'lastupdated': lastupdated};
  factory CategoryLogicModel.fromRepository(CategoryRepoModel categoryrepo) {
    return CategoryLogicModel(
        categories: categoryrepo.categories, lastupdated: DateTime.now());
  }
  CategoryLogicModel copyWith(
      {List<Category>? categories, DateTime? lastupdated}) {
    return CategoryLogicModel(
        categories: categories ?? this.categories,
        lastupdated: lastupdated ?? this.lastupdated);
  }
}
