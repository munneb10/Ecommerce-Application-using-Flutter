import 'package:flutter_tst/BLOC/productBloc/ApiLayer/api_client.dart';
import 'package:flutter_tst/BLOC/productBloc/RepoLayer/repoModel.dart';

class ProductRepo {
  ApiClient api = ApiClient();
  void uploadProduct(RepoModel product) {
    api.uploadProduct(product.toApiModel());
  }
}
