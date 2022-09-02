// ignore_for_file:prefer_const_constructors,

import 'package:flutter/material.dart';
import 'package:flutter_tst/BLOC/AllProductBloc/blocLayer/all_product_bloc.dart';
import 'package:flutter_tst/BLOC/GetProductBloc/repoLayer/repo.dart';
import 'package:flutter_tst/BLOC/categoryBloc/blocLayer/category_bloc.dart';
import 'package:flutter_tst/BLOC/categoryBloc/repoLayer/category_repo.dart';
import 'package:flutter_tst/BLOC/productBloc/ApiLayer/api_model.dart';
import 'package:flutter_tst/BLOC/productBloc/RepoLayer/repo.dart';
import 'package:flutter_tst/BLOC/productBloc/blocLayer/bloc.dart';
import 'package:flutter_tst/BLOC/GetProductBloc/blocLayer/bloc.dart';
import 'package:flutter_tst/pages/SellerPages/add_product.dart';
import 'package:flutter_tst/pages/SellerPages/uploading_products.dart';
import 'package:flutter_tst/pages/UserPages/cart.dart';
import 'package:flutter_tst/pages/UserPages/Orders.dart';
import 'package:flutter_tst/pages/UserPages/paymentMethods.dart';
import 'package:flutter_tst/pages/UserPages/paymentPages/cash_delievery.dart';
import 'package:flutter_tst/pages/UserPages/product_preview.dart';
import 'package:flutter_tst/pages/UserPages/view_video.dart';
import 'package:flutter_tst/pages/UserPages/videos_preview.dart';
import 'package:flutter_tst/pages/UtilsPage/login.dart';
import 'package:flutter_tst/pages/UtilsPage/signin.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'pages/UserPages/homepage.dart';
import 'package:flutter_tst/utils/navigator_middleware.dart';

void main() {
  runApp(Min());
}

RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class Min extends StatefulWidget {
  const Min({Key? key}) : super(key: key);
  @override
  State<Min> createState() => _MinState();
}

class _MinState extends State<Min> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => CategoryRepo()),
        RepositoryProvider(create: (context) => ProductRepo()),
        RepositoryProvider(create: (context) => GetProductRepo())
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<CategoryBloc>(
              create: (BuildContext context) =>
                  CategoryBloc(context.read<CategoryRepo>())),
          BlocProvider<AddCategoryBloc>(
              create: (BuildContext context) =>
                  AddCategoryBloc(context.read<CategoryRepo>())),
          BlocProvider<ProductBloc>(
              create: (BuildContext context) => ProductBloc()),
          BlocProvider<AllProductBloc>(
              create: (BuildContext context) =>
                  AllProductBloc(context.read<ProductRepo>())),
          BlocProvider<GetProductBloc>(
              create: (BuildContext context) =>
                  GetProductBloc(context.read<GetProductRepo>()))
        ],
        child: MaterialApp(
          navigatorObservers: [routeObserver],
          debugShowCheckedModeBanner: false,
          home: CashOnDelievery(),
          // routes on which route go to which page
          routes: {
            "/cart": (context) => RouteAwareWidget('cart', child: CartPage()),
            "/UsersOrders": (context) =>
                RouteAwareWidget('User Orders', child: UserOrders()),
            "/AllProducts": (context) =>
                RouteAwareWidget('HomePage', child: Homepage()),
            "/Signin": (context) => RouteAwareWidget("signIn", child: Signin()),
            "/Login": (context) => RouteAwareWidget("LogIn", child: LogIn()),
            "/AddProduct": (context) =>
                RouteAwareWidget("AddProduct", child: AddProduct()),
            "/UploadingProduct": (context) => RouteAwareWidget(
                "Uploading Product",
                child: UploadingProducts())
          },
          onUnknownRoute: (RouteSettings settings) {
            if (settings.name == '/view_video') {
              Map<String, String> data =
                  settings.arguments as Map<String, String>;
              return MaterialPageRoute(
                  builder: (context) => VideoView(url: data['url'] as String));
            }
            if (settings.name == '/previewProduct') {
              ApiModel data = settings.arguments as ApiModel;
              return MaterialPageRoute(
                  builder: (context) => ProductPreview(product: data));
            }
            if (settings.name == '/viewvideo') {
              ApiModel data = settings.arguments as ApiModel;
              return MaterialPageRoute(
                  builder: (context) => VideosPreview(product: data));
            }
          },
        ),
      ),
    );
  }
}
