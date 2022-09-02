import 'package:bloc/bloc.dart';
import 'package:flutter_tst/BLOC/categoryBloc/blocLayer/category_logic_model.dart';
import 'package:flutter_tst/BLOC/categoryBloc/repoLayer/category_repo.dart';
import 'package:flutter_tst/BLOC/categoryBloc/blocLayer/category_state.dart';

class CategoryEvents {}

class GetCategoryEvent extends CategoryEvents {}

class SearchCategoryEvent extends CategoryEvents {
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

class CategoryBloc extends Bloc<CategoryEvents, CategoryState> {
  CategoryBloc(this.categoryrepo) : super(CategoryInitialState()) {
    on<GetCategoryEvent>(_getcategories);
    on<SearchCategoryEvent>(_searchcategory);
  }
  _getcategories(event, emit) async {
    emit(CategoryLoadingState().copyWith(status: CategoryStatus.loading));
    try {
      final categories =
          CategoryLogicModel.fromRepository(await categoryrepo.getCategories());
      emit(CategorySuccessState().copyWith(
          status: CategoryStatus.success, categoriesdata: categories));
    } catch (e) {
      emit(CategoryFailedState().copyWith(
          status: CategoryStatus.failure,
          categoriesdata: CategoryLogicModel.empty));
    }
  }

  _searchcategory(event, emit) async {
    String val = event.search;
    if (event.runtimeType == SearchCategoryEvent &&
        val != '' &&
        state.status != CategoryStatus.loading &&
        state.status != CategoryStatus.failure) {
      emit(CategoryLoadingState().copyWith(
          status: CategoryStatus.loading,
          categoriesdata: CategoryLogicModel.empty));
      try {
        final categories = CategoryLogicModel.fromRepository(
            await categoryrepo.searchCategory(val));
        emit(SearchCategoryState(val).copyWith(
            status: CategoryStatus.success, categoriesdata: categories));
      } catch (e) {
        emit(CategoryFailedState().copyWith(
            status: CategoryStatus.failure,
            categoriesdata: CategoryLogicModel.empty));
      }
    } else {
      emit(CategoryInitialState());
    }
  }

  final CategoryRepo categoryrepo;
}

class AddCategoryEvents {}

class AddCategory extends AddCategoryEvents {
  String category;
  AddCategory(this.category) : super();
}

class ResetAddCategory extends AddCategoryEvents {}

class AddCategoryBloc extends Bloc<AddCategoryEvents, AddCategoryState> {
  AddCategoryBloc(this.categoryrepo) : super(AddCategoryState()) {
    on<AddCategory>(_addcategory);
    on<ResetAddCategory>(_resetcategory);
  }
  _resetcategory(event, emit) async {
    emit(AddCategoryState());
  }

  _addcategory(event, emit) async {
    String val = event.category;
    emit(AddCategoryState().copyWith(
        status: AddCategoryStatus.inserting,
        categoriesdata: CategoryLogicModel.empty));
    try {
      final categories = CategoryLogicModel.fromRepository(
          await categoryrepo.insertCategory(val));
      emit(AddCategoryState().copyWith(
          status: AddCategoryStatus.inserted, categoriesdata: categories));
    } catch (e) {
      emit(AddCategoryState().copyWith(
          status: AddCategoryStatus.failure,
          categoriesdata: CategoryLogicModel.empty));
    }
  }

  final CategoryRepo categoryrepo;
}
