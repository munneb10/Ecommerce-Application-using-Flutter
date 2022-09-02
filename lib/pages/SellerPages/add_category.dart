// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, non_constant_identifier_names, unrelated_type_equality_checks
import 'package:flutter/material.dart';
import 'package:flutter_tst/BLOC/categoryBloc/blocLayer/category_bloc.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/button.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/input.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/menu/menu.dart';
import 'package:flutter_tst/Widgets/sellerpage_widgets/add_category_widgets/category_edit_view.dart';
import 'package:flutter_tst/utils/colors.dart';
import 'package:flutter_tst/utils/keyboarddetector.dart/keyboarddetector.dart';
import 'package:flutter_tst/BLOC/categoryBloc/blocLayer/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  bool iskeyboardopen = false;
  bool isAddCategory = false;
  String categoryname = "";
  bool is_msg = false;
  int length = -1;
  bool lock = false;
  String message = "";
  bool is_result = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Material(
      child: KeyBoardDetector(
        onkeyboardclose: () {
          setState(() {
            iskeyboardopen = false;
          });
        },
        onkeyboardopen: () {
          setState(() {
            iskeyboardopen = true;
          });
        },
        child: Stack(children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                  AppColors.base_background_begin,
                  AppColors.base_background_end
                ])),
            child: Column(
              children: [
                SizedBox(
                  height: 16,
                ),
                AppMenu(menu: true, home: true),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "All Categories",
                  style: TextStyle(
                      color: AppColors.color,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
                Input_box(
                  textfieldvalue: "Search Category",
                  issearch: true,
                  onchange: (val) {
                    BlocProvider.of<CategoryBloc>(context)
                        .add(SearchCategoryEvent(val));
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Categories",
                  style: TextStyle(
                      color: AppColors.color,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Button(
                    buttonValue: "Add Category",
                    onclick: () {
                      setState(() {
                        isAddCategory = true;
                      });
                    }),
                SizedBox(
                  height: 30,
                ),
                BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                  return Text(
                    'Total ${state.categoriesdata.categories.length}',
                    style: TextStyle(color: AppColors.color, fontSize: 16),
                  );
                }),
                SizedBox(
                  height: 20,
                ),
                BlocBuilder<CategoryBloc, CategoryState>(
                    builder: (context, state) {
                  if (state.status == CategoryStatus.initial &&
                      state is CategoryInitialState) {
                    BlocProvider.of<CategoryBloc>(context)
                        .add(GetCategoryEvent());
                  }
                  if (state.status == CategoryStatus.loading) {
                    return CircularProgressIndicator(
                      color: AppColors.fore_background_end,
                    );
                  } else if (state.status == CategoryStatus.success) {
                    return Flexible(
                      child: ListView.builder(
                        itemCount: state.categoriesdata.categories.length,
                        itemBuilder: (context, index) {
                          return EditCategoryView(
                              toshow: state.categoriesdata.categories[index]);
                        },
                      ),
                    );
                  } else if (state.status == CategoryStatus.failure) {
                    return Column(children: [
                      Text(
                        'Some Error Occured',
                        style: TextStyle(color: AppColors.color, fontSize: 16),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Button(buttonValue: "Try Again", onclick: () {})
                    ]);
                  } else {
                    return Text("Just To Pass");
                  }
                })
              ],
            ),
          ),
          isAddCategory
              ? Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  color: Colors.black.withOpacity(0.3),
                  child: Align(
                    alignment:
                        iskeyboardopen ? Alignment.topCenter : Alignment.center,
                    child: Container(
                      width: 300,
                      height: 340,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                            AppColors.base_background_begin,
                            AppColors.base_background_end
                          ])),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          is_msg
                              ? Text(
                                  message,
                                  style: TextStyle(
                                      color: AppColors.color, fontSize: 12),
                                )
                              : Text(""),
                          Input_box(
                            textfieldvalue: "Category Name",
                            onchange: (val) => categoryname = val,
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          BlocBuilder<AddCategoryBloc, AddCategoryState>(
                              builder: (context, state) {
                            if (state.status == AddCategoryStatus.initial) {
                              return Text("");
                            } else if (state.status ==
                                AddCategoryStatus.inserting) {
                              return Column(
                                children: [
                                  CircularProgressIndicator(
                                    color: AppColors.fore_background_begin,
                                  ),
                                  Text("Insering Category")
                                ],
                              );
                            } else if (state.status ==
                                AddCategoryStatus.inserted) {
                              Future.delayed(Duration(milliseconds: 1000), () {
                                if (isAddCategory) {
                                  setState(() {
                                    isAddCategory = false;
                                    context
                                        .read<CategoryBloc>()
                                        .add(GetCategoryEvent());
                                    context
                                        .read<AddCategoryBloc>()
                                        .add(ResetAddCategory());
                                  });
                                } else {
                                  context
                                      .read<CategoryBloc>()
                                      .add(GetCategoryEvent());
                                  context
                                      .read<AddCategoryBloc>()
                                      .add(ResetAddCategory());
                                }
                              });
                              return Text(
                                'Category Inserted Successfully',
                                style: TextStyle(
                                    color: AppColors.color, fontSize: 16),
                              );
                            } else if (state.status ==
                                AddCategoryStatus.failure) {
                              return Text(
                                'Category Insertion Failed',
                                style: TextStyle(
                                    color: AppColors.color, fontSize: 16),
                              );
                            } else {
                              return Text("data");
                            }
                          }),
                          Button(
                              buttonValue: "Add Category",
                              onclick: () {
                                BlocProvider.of<AddCategoryBloc>(context)
                                    .add(AddCategory(categoryname));
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          Button(
                              buttonValue: "Cancel",
                              onclick: () {
                                setState(() {
                                  isAddCategory = false;
                                });
                              })
                        ],
                      ),
                    ),
                  ),
                )
              : Container(),
        ]),
      ),
    ));
  }
}

typedef FetchCategory = void Function();
