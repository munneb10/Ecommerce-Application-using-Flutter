// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, unused_import

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tst/BLOC/GetProductBloc/blocLayer/bloc.dart';
import 'package:flutter_tst/BLOC/productBloc/ApiLayer/api_model.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/sidemenu.dart';
import 'package:flutter_tst/Widgets/homepage_widgets/filters.dart';
import 'package:flutter_tst/utils/colors.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/menu/menu.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/input.dart';
import 'package:flutter_tst/Widgets/Products_view_widgets/grid_view_products.dart';

import '../../BLOC/GetProductBloc/blocLayer/state.dart';

class Homepage extends StatefulWidget {
  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  int a = 150;
  bool isDone = false;
  bool isSlideOpen = false;
  Size? size;
  double top = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return SafeArea(
      child: Material(
        child: Stack(
          children: [
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
                    height: 15,
                  ),
                  AppMenu(
                    menu: true,
                    cart: true,
                    onmenuclick: () {
                      setState(() {
                        isSlideOpen = true;
                      });
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Input_box(
                    textfieldvalue: "Search",
                    onFilter: () {
                      setState(() {
                        isDone = true;
                      });
                    },
                    onSearch: (searchvalue) {},
                    issearch: true,
                    isfilter: true,
                  ),
                  Flexible(
                    child: Padding(
                        padding: const EdgeInsets.only(left: 5, right: 5),
                        child: InfiniteProductScroll()),
                  )
                ],
              ),
            ),
            isDone == true
                ? FilterWidget(
                    onOk: () {
                      setState(() {
                        isDone = false;
                      });
                    },
                  )
                : Container(),
            isSlideOpen == true
                ? SafeArea(
                    child: SideMenu(onOk: () {
                      setState(() {
                        isSlideOpen = false;
                      });
                    }),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}

class InfiniteProductScroll extends StatefulWidget {
  const InfiniteProductScroll({super.key});

  @override
  State<InfiniteProductScroll> createState() => _InfiniteProductScrollState();
}

class _InfiniteProductScrollState extends State<InfiniteProductScroll> {
  ScrollController scrollController = ScrollController();
  double previousScrollPosition = 0;
  List<ApiModel> products = [];
  bool hasProduct = true;
  @override
  void initState() {
    context.read<GetProductBloc>().add(GetProductEvent());
    scrollController.addListener(() {
      double newScroll = scrollController.position.pixels;
      previousScrollPosition = scrollController.position.pixels;
      if (newScroll < previousScrollPosition) {
        return;
      }
      if (scrollController.position.maxScrollExtent ==
          scrollController.offset) {
        setState(() {
          context.read<GetProductBloc>().add(GetProductEvent());
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GetProductBloc, GetProductState>(
      listener: ((context, state) {
        if (state.status == ProductStatus.completed) {
          hasProduct = false;
        }
        if (state.status == ProductStatus.success) {
          if (state.productsdata.isNotEmpty) {
            products.clear();
            products.addAll(state.productsdata);
            setState(() {});
          } else {
            setState(() {
              hasProduct = false;
            });
          }
        }
      }),
      child: OrientationBuilder(
        builder: (context, orientation) => GridView.builder(
          controller: scrollController,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisExtent: 250,
              crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 10.0),
          itemCount: products.length + 1,
          itemBuilder: (BuildContext context, int index) {
            if (index < products.length) {
              return Products_view(
                product: products[index],
              );
            }
            return hasProduct
                ? Center(child: CircularProgressIndicator())
                : Center(
                    child: Text(
                    "No More Products",
                    style: TextStyle(fontSize: 20),
                  ));
            // }
            // print("hi");
            // return Container();
          },
        ),
      ),
    );
  }
}
