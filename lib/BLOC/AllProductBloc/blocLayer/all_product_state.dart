// ignore_for_file: file_names
import 'package:flutter_tst/BLOC/productBloc/blocLayer/blocModel.dart';

class AllProductState {
  late List<blocModel> uploadedProducts;
  late List<blocModel> uploadingProducts;
  AllProductState() {
    uploadedProducts = [];
    uploadingProducts = [];
  }
  AllProductState.fromParams(this.uploadedProducts, this.uploadingProducts);
  AllProductState copyWith(
      {List<blocModel>? uploadedProducts, List<blocModel>? uploadingProducts}) {
    return AllProductState.fromParams(uploadedProducts ?? this.uploadedProducts,
        uploadingProducts ?? this.uploadingProducts);
  }

  void addUploadedProduct(blocModel product) {
    uploadingProducts.remove(product);
    uploadedProducts.add(product);
  }

  void addUploadingProduct(blocModel product) {
    uploadingProducts.add(product);
  }
}
