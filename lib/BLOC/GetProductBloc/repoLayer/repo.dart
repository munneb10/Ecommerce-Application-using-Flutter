import 'package:flutter_tst/BLOC/GetProductBloc/apiLayer/ApiLayer.dart';
import 'package:flutter_tst/BLOC/GetProductBloc/repoLayer/repo_model.dart';

class GetProductRepo {
  GetProductRepo({ProductApiClient? productApiClient})
      : _productApiClient = productApiClient ?? ProductApiClient();
  final ProductApiClient _productApiClient;
  Future<ProductRepoModel> getProducts(
      int offset, int length, String sortKey) async {
    final productResponse =
        await _productApiClient.getProducts(offset, length, sortKey);
    return ProductRepoModel(products: productResponse.products);
  }

  // Future<CategoryRepoModel> searchCategory(String query) async {
  //   final categoryResponse = await _categoryApiClient.searchCategories(query);
  //   return CategoryRepoModel(categories: categoryResponse.categories);
  // }

  // Future<CategoryRepoModel> insertCategory(String categoryName) async {
  //   final categoryResponse =
  //       await _categoryApiClient.insertCategory(categoryName);
  //   return CategoryRepoModel(categories: categoryResponse.categories);
  // }
}
