import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter_tst/BLOC/GetProductBloc/blocLayer/state.dart';
import 'package:flutter_tst/BLOC/GetProductBloc/repoLayer/repo.dart';
import 'package:flutter_tst/BLOC/categoryBloc/blocLayer/category_state.dart';

class ProductEvents {}

class GetProductEvent extends ProductEvents {}

class SearchCategoryEvent extends ProductEvents {
  String search;
  SearchCategoryEvent(this.search) : super();
}

class CategoryInitialState extends CategoryState {
  CategoryInitialState() : super();
}

class SearchCategoryState extends CategoryState {
  String search;
  SearchCategoryState(this.search) : super();
}

class CategorySuccessState extends CategoryState {
  CategorySuccessState() : super();
}

class CategoryLoadingState extends CategoryState {
  CategoryLoadingState() : super();
}

class CategoryFailedState extends CategoryState {
  CategoryFailedState() : super();
}

class GetProductBloc extends Bloc<ProductEvents, GetProductState> {
  GetProductBloc(this.productrepo)
      : super(GetProductState(
            status: ProductStatus.initial,
            productsdata: [],
            offset: 0,
            length: 10,
            sortKey: "_id")) {
    on<GetProductEvent>(_getproducts);
    // on<SearchCategoryEvent>(_searchcategory);
  }
  _getproducts(event, emit) async {
    emit(state.copyWith(status: ProductStatus.loading));
    try {
      final products = await productrepo.getProducts(
          state.offset, state.length, state.sortKey);
      final toCheck = await productrepo.getProducts(
          state.offset + state.length, state.length, state.sortKey);
      // print(toCheck.products);
      state.productsdata.addAll(products.products);
      emit(state.copyWith(
          status: ProductStatus.success,
          productsdata: state.productsdata,
          offset: (state.offset + state.length)));
      if (toCheck.products.isEmpty) {
        emit(state.copyWith(status: ProductStatus.completed));
      }
    } catch (e) {
      print(e);
      emit(state.copyWith(status: ProductStatus.failure));
    }
  }

  // _searchcategory(event, emit) async {
  //   String val = event.search;
  //   if (event.runtimeType == SearchCategoryEvent &&
  //       val != '' &&
  //       state.status != CategoryStatus.loading &&
  //       state.status != CategoryStatus.failure) {
  //     emit(CategoryLoadingState().copyWith(
  //         status: CategoryStatus.loading,
  //         categoriesdata: CategoryLogicModel.empty));
  //     try {
  //       final categories = CategoryLogicModel.fromRepository(
  //           await categoryrepo.searchCategory(val));
  //       emit(SearchCategoryState(val).copyWith(
  //           status: CategoryStatus.success, categoriesdata: categories));
  //     } catch (e) {
  //       emit(CategoryFailedState().copyWith(
  //           status: CategoryStatus.failure,
  //           categoriesdata: CategoryLogicModel.empty));
  //     }
  //   } else {
  //     emit(CategoryInitialState());
  //   }
  // }

  final GetProductRepo productrepo;
}

// class AddProductEvents {}

// class AddCategory extends AddProductEvents {
//   String category;
//   AddCategory(this.category) : super();
// }

// class ResetAddCategory extends AddProductEvents {}

// class AddCategoryBloc extends Bloc<AddProductEvents, AddCategoryState> {
//   AddCategoryBloc(this.categoryrepo) : super(AddCategoryState()) {
//     on<AddCategory>(_addcategory);
//     on<ResetAddCategory>(_resetcategory);
//   }
//   _resetcategory(event, emit) async {
//     emit(AddCategoryState());
//   }

//   _addcategory(event, emit) async {
//     String val = event.category;
//     emit(AddCategoryState().copyWith(
//         status: AddCategoryStatus.inserting,
//         categoriesdata: CategoryLogicModel.empty));
//     try {
//       final categories = CategoryLogicModel.fromRepository(
//           await categoryrepo.insertCategory(val));
//       emit(AddCategoryState().copyWith(
//           status: AddCategoryStatus.inserted, categoriesdata: categories));
//     } catch (e) {
//       emit(AddCategoryState().copyWith(
//           status: AddCategoryStatus.failure,
//           categoriesdata: CategoryLogicModel.empty));
//     }
//   }

//   final CategoryRepo categoryrepo;
// }
