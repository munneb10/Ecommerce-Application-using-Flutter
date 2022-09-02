import 'package:flutter_tst/BLOC/categoryBloc/ApiLayer/category_api_client.dart';
import 'package:flutter_tst/BLOC/categoryBloc/repoLayer/category_repo_model.dart';

class CategoryRepo {
  CategoryRepo({CategoryApiClient? categoryApiClient})
      : _categoryApiClient = categoryApiClient ?? CategoryApiClient();
  final CategoryApiClient _categoryApiClient;
  Future<CategoryRepoModel> getCategories() async {
    final categoryResponse = await _categoryApiClient.getCategories();
    return CategoryRepoModel(categories: categoryResponse.categories);
  }

  Future<CategoryRepoModel> searchCategory(String query) async {
    final categoryResponse = await _categoryApiClient.searchCategories(query);
    return CategoryRepoModel(categories: categoryResponse.categories);
  }

  Future<CategoryRepoModel> insertCategory(String categoryName) async {
    final categoryResponse =
        await _categoryApiClient.insertCategory(categoryName);
    return CategoryRepoModel(categories: categoryResponse.categories);
  }
}
