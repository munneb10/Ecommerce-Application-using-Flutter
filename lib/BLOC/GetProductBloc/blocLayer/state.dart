import 'package:flutter_tst/BLOC/productBloc/ApiLayer/api_model.dart';

enum ProductStatus { initial, loading, success, failure, completed }

// extension CategoryStatusX on ProductStatus {
//   bool get isInitial => this == ProductStatus.initial;
//   bool get isLoading => this == ProductStatus.loading;
//   bool get isSuccess => this == ProductStatus.success;
//   bool get isFailure => this == ProductStatus.failure;
// }

class GetProductState {
  GetProductState(
      {required this.status,
      required this.productsdata,
      required this.offset,
      required this.length,
      required this.sortKey});
  ProductStatus status;
  List<ApiModel> productsdata;
  int offset;
  int length;
  String sortKey;
  dynamic copyWith(
      {ProductStatus? status,
      List<ApiModel>? productsdata,
      int? offset,
      int? length,
      String? sortKey}) {
    return GetProductState(
      status: status ?? this.status,
      productsdata: productsdata ?? this.productsdata,
      offset: offset ?? this.offset,
      length: length ?? this.length,
      sortKey: sortKey ?? this.sortKey,
    );
  }
}
