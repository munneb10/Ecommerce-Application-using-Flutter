// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_tst/Widgets/cart_widgets/cart_view.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/menu/menu.dart';
import 'package:flutter_tst/utils/colors.dart';

class CartPage extends StatefulWidget {
  CartPage({Key? key}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        child: Stack(
          children: [
            Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                      AppColors.base_background_begin,
                      AppColors.base_background_end
                    ])),
                child: OrientationBuilder(builder: (context, orient) {
                  double height = MediaQuery.of(context).size.height;
                  orient == Orientation.portrait
                      ? height = height - 300
                      : height = height - 150;
                  return Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      AppMenu(
                        menu: true,
                        home: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: height,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 5, right: 5),
                          child: OrientationBuilder(
                            builder: (context, orientation) => GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      // childAspectRatio: 2.3,
                                      mainAxisExtent: 155,
                                      crossAxisCount:
                                          orientation == Orientation.portrait
                                              ? 1
                                              : 2,
                                      crossAxisSpacing: 4.0,
                                      mainAxisSpacing: 10.0),
                              itemCount: 10,
                              itemBuilder: (BuildContext context, int index) {
                                return CartView();
                              },
                            ),
                          ),
                        ),
                      )
                    ],
                  );
                })),
            Positioned(
              bottom: 10,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                AppColors.fore_background_begin,
                                AppColors.fore_background_end
                              ])),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 15, right: 15, top: 5, bottom: 5),
                            child: Text(
                              "Total : 180000\$",
                              style: TextStyle(
                                  color: AppColors.color,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                AppColors.fore_background_begin,
                                AppColors.fore_background_end
                              ])),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 40, right: 40, top: 5, bottom: 5),
                            child: Text(
                              "Proceed To Pay",
                              style: TextStyle(
                                  color: AppColors.color,
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
