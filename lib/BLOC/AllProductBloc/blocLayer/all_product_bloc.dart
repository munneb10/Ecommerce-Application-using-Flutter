import 'package:bloc/bloc.dart';
import 'package:flutter_tst/BLOC/AllProductBloc/blocLayer/all_product_state.dart';
import 'package:flutter_tst/BLOC/productBloc/RepoLayer/repo.dart';
import 'package:flutter_tst/BLOC/productBloc/blocLayer/blocModel.dart';

class AllProductEvent {}

class AddProducts extends AllProductEvent {
  AddProducts(this.product);
  blocModel product;
}

class AllProductBloc extends Bloc<AllProductEvent, AllProductState> {
  ProductRepo productRepo;
  AllProductBloc(this.productRepo) : super(AllProductState()) {
    on<AddProducts>(uploadProduct);
  }
  Future<void> uploadProduct(event, emit) async {
    state.addUploadingProduct(event.product);
    event.product.onProductUploading = () {
      emit(state.copyWith(uploadingProducts: state.uploadingProducts));
    };
    event.product.onProductUploaded = () {
      state.addUploadedProduct(event.product);
      emit(state.copyWith(uploadedProducts: state.uploadedProducts));
    };
    await event.product.upload(productRepo);
  }
}
