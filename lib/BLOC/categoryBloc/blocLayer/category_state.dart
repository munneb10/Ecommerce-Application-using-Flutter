import 'package:flutter_tst/BLOC/categoryBloc/blocLayer/category_logic_model.dart';

enum CategoryStatus { initial, loading, success, failure }

enum AddCategoryStatus { initial, inserting, inserted, failure }

extension CategoryStatusX on CategoryStatus {
  bool get isInitial => this == CategoryStatus.initial;
  bool get isLoading => this == CategoryStatus.loading;
  bool get isSuccess => this == CategoryStatus.success;
  bool get isFailure => this == CategoryStatus.failure;
}

class CategoryState {
  CategoryState({
    this.status = CategoryStatus.initial,
    CategoryLogicModel? categoriesdata,
  }) : categoriesdata = categoriesdata ?? CategoryLogicModel.empty;
  final CategoryStatus status;
  final CategoryLogicModel categoriesdata;
  factory CategoryState.fromJson(json) {
    return CategoryState(
        status: json['status'], categoriesdata: json['categoriesdata']);
  }
  Map toJson() => {'status': status, 'categoriesdata': categoriesdata};
  dynamic copyWith(
      {CategoryStatus? status, CategoryLogicModel? categoriesdata}) {
    return CategoryState(
        status: status ?? this.status,
        categoriesdata: categoriesdata ?? this.categoriesdata);
  }
}

class AddCategoryState {
  AddCategoryState({
    this.status = AddCategoryStatus.initial,
    CategoryLogicModel? categoriesdata,
  }) : categoriesdata = categoriesdata ?? CategoryLogicModel.empty;
  final AddCategoryStatus status;
  final CategoryLogicModel categoriesdata;
  factory AddCategoryState.fromJson(json) {
    return AddCategoryState(
        status: json['status'], categoriesdata: json['categoriesdata']);
  }
  Map toJson() => {'status': status, 'categoriesdata': categoriesdata};
  dynamic copyWith(
      {AddCategoryStatus? status, CategoryLogicModel? categoriesdata}) {
    return AddCategoryState(
        status: status ?? this.status,
        categoriesdata: categoriesdata ?? this.categoriesdata);
  }
}
