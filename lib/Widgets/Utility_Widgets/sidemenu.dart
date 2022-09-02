// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_cast, must_be_immutable, sort_child_properties_last

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tst/utils/colors.dart';
import 'package:flutter_tst/utils/secure_storage.dart';

class SideMenu extends StatefulWidget {
  VoidCallback onOk;
  SideMenu({Key? key, required this.onOk}) : super(key: key);

  @override
  _SideMenuState createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  bool islogined = false;
  bool isSeller = false;
  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 150), vsync: this);
    animation = Tween<double>(begin: -300, end: 0).animate(controller)
      ..addListener(() {
        setState(() {
          // The state that has changed here is the animation object’s value.
        });
      });
    controller.forward();
    logined();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void logined() async {
    var username = await UserStorage.read("userid");
    print(username);
    var userrole = "";
    if (username != null) {
      islogined = true;
    } else {
      islogined = false;
    }
    if (userrole == '0' || userrole == null) {
      isSeller = false;
    } else {
      isSeller = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (value) {
        if (value.primaryVelocity! > 0) {
          controller.reverse();
          Future.delayed(Duration(milliseconds: 200), () {
            widget.onOk();
          });
        }
      },
      child: Stack(
        children: [
          GestureDetector(
            onTap: () {
              controller.reverse();
              Future.delayed(Duration(milliseconds: 200), () {
                widget.onOk();
              });
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.black.withOpacity(0.4),
            ),
          ),
          AnimatedBuilder(
            child: Container(
              width: 300,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                    AppColors.base_background_begin,
                    AppColors.base_background_end
                  ])),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.reverse();
                        Future.delayed(Duration(milliseconds: 200), () {
                          widget.onOk();
                        });
                      },
                      child: Icon(
                        Icons.cancel_presentation,
                        color: AppColors.color,
                        size: 40,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamedAndRemoveUntil(
                                '/AllProducts',
                                (Route<dynamic> route) => false);
                          },
                          child: MenuItem(menuitemname: "Home")),
                    ),
                    isSeller && islogined
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('/AddProduct');
                                },
                                child: MenuItem(menuitemname: "Add Product")),
                          )
                        : Container(),
                    isSeller && islogined
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('/UploadingProduct');
                                },
                                child: MenuItem(
                                    menuitemname: "Uploading Product")),
                          )
                        : Container(),
                    islogined
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: MenuItem(menuitemname: "Your Orders"),
                          )
                        : Container(),
                    !isSeller && islogined
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: MenuItem(menuitemname: "Cart"),
                          )
                        : Container(),
                    !isSeller && islogined
                        ? Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: MenuItem(menuitemname: "Become Seller"),
                          )
                        : Container(),
                    islogined
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/Login');
                                },
                                child: MenuItem(menuitemname: "Log In")),
                          ),
                    islogined
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed('/Signin');
                                },
                                child: MenuItem(menuitemname: "Sign In")),
                          ),
                    !islogined
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 20),
                            child: GestureDetector(
                                onTap: () async {
                                  UserStorage.deletekey("userid");
                                  controller.reverse();
                                  Future.delayed(Duration(milliseconds: 200),
                                      () {
                                    widget.onOk();
                                  });
                                },
                                child: MenuItem(menuitemname: "Log Out")),
                          ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 0, right: 0, top: 20),
                      child: MenuItem(menuitemname: "Terms And Conditions"),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 20),
                      child: MenuItem(menuitemname: "About us"),
                    ),
                  ],
                ),
              ),
            ),
            animation: animation,
            builder: (context, child) {
              return Positioned(
                  bottom: 0,
                  top: 0,
                  right: animation.value,
                  child: child as Widget);
            },
          ),
        ],
      ),
    );
  }
}

class MenuItem extends StatefulWidget {
  late String menuitemname;
  MenuItem({Key? key, required this.menuitemname}) : super(key: key);

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.menuitemname,
      style: TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
          color: AppColors.color,
          decoration: TextDecoration.underline,
          decorationThickness: 2),
    );
  }
}
