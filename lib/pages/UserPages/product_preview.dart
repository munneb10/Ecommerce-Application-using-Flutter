// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/counterwidget.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/dropdown.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/rating_widget.dart';
import 'package:flutter_tst/utils/colors.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/menu/menu.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_tst/utils/host.dart';
import '../../BLOC/productBloc/ApiLayer/api_model.dart';

typedef WidgetCallBack = void Function(BuildContext context);

class ProductPreview extends StatefulWidget {
  ApiModel product;
  ProductPreview({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductPreview> createState() => _ProductPreviewState();
}

class _ProductPreviewState extends State<ProductPreview> {
  int actIndex = 0;
  int count = 0;
  int ratings = 0;
  int quantity = 0;
  late Widget buildIndicators;
  late OverlayEntry floatingdrop;
  late List<Widget> dropdowns = [];
  bool isDropDownOpen = false;
  late ApiModel product;
  List<List> attrVals = [];
  List<String> selected = [];
  List<String> order = [];
  List<Widget> atteWidget = [];
  Map<String, int> availVal = {};
  List<List> tempatrVals = [];
  List<bool> isSelected = [];
  bool loadFirst = true;
  //  find attr name by using the value from which attribute
  //  the value exist
  String findAttrName(String attrVal) {
    for (MapEntry<String, dynamic> p in product.attr.entries) {
      if (p.value.contains(attrVal)) {
        return p.key;
      }
    }
    return "";
  }

  void handleDropDownAttr() {
    if (loadFirst == true) {
      loadFirst = false;
      // containing the filtered value
      // adding all the values of product attributes in
      // availVal to avoid value errors
      availVal.addAll(product.attrVal);
      // cleaning the data with 0 values and having the / at the end
      for (var element in product.attrVal.entries) {
        if (element.value == 0) {
          availVal.remove(element.key);
        } else {
          String ke = element.key.substring(0, element.key.length - 1);
          int val = element.value;
          availVal.remove(element.key);
          availVal[ke] = val;
        }
      }
      for (var element in availVal.entries.first.key.split('/')) {
        String s = findAttrName(element);
        selected.add(s);
        order.add(s);
      }
      for (MapEntry<String, int> element in availVal.entries) {
        List<String> val = element.key.split("/");
        for (var v in val) {
          if (attrVals.length != val.length) {
            attrVals.add([]);
          }
          if (!attrVals[val.indexOf(v)].contains(v)) {
            attrVals[val.indexOf(v)].add(v);
          }
        }
      }
      tempatrVals.addAll(attrVals);
    }
    for (var i = 0; i < selected.length; i++) {
      isSelected.add(false);
    }
  }

  @override
  void initState() {
    product = widget.product;
    handleDropDownAttr();
    super.initState();
  }

  List<Widget> getWidgets() {
    atteWidget.clear();
    for (var i = 0; i < attrVals.length; i++) {
      atteWidget.add(DropDown(
        key: UniqueKey(),
        itemcount: attrVals[i].length,
        name: selected[i],
        onchanged: (String value) {
          selected[i] = value;
          isSelected[i] = true;
          List<List> selec = [];
          for (var i = 0; i < attrVals.length; i++) {
            selec.add([]);
          }
          int quan = 0;
          Map<String, int> ver1 = {};
          for (MapEntry<String, int> val in availVal.entries) {
            List<String> values = val.key.split('/');
            if (values.contains(selected[i])) {
              ver1[val.key] = val.value;
            }
          }
          List<bool> isSelectedChanged = List.filled(isSelected.length, false);
          for (MapEntry<String, int> el in ver1.entries) {
            List<String> values = el.key.split('/');
            for (MapEntry<int, bool> element in isSelected.asMap().entries) {
              if (element.value == true) {
                if (values.contains(selected[element.key])) {
                  isSelected[element.key] = true;
                  isSelectedChanged[element.key] = true;
                }
              }
              for (var atVal in values) {
                if (!selec[values.indexOf(atVal)].contains(atVal)) {
                  selec[values.indexOf(atVal)].add(atVal);
                }
              }
            }
          }
          quantity = 0;
          selec[i] = tempatrVals[i];
          for (MapEntry<int, bool> a in isSelectedChanged.asMap().entries) {
            if (a.value == false) {
              selected[a.key] = order[a.key];
            }
          }
          for (var element in ver1.entries) {
            List<String> valf = element.key.split('/');
            bool to_add = true;
            for (var el in selected) {
              if (!order.contains(el)) {
                if (!valf.contains(el)) {
                  to_add = false;
                  break;
                }
              }
            }
            if (to_add) {
              quantity += element.value;
            }
          }
          attrVals = selec;
          setState(() {});
          if (count > quantity) {
            count = quantity;
          }
        },
        values: attrVals[i],
      ));
    }
    return atteWidget;
  }

  @override
  Widget build(BuildContext context) {
    print("bui");
    return SafeArea(
      child: Material(
        child: Container(
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
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 15,
                ),
                AppMenu(
                  menu: true,
                  cart: true,
                  home: true,
                ),
                SizedBox(
                  height: 30,
                ),
                CarouselSlider.builder(
                  itemCount: product.imagesLink.length,
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      ImageBuild(
                    imageLink: product.imagesLink[itemIndex],
                  ),
                  options: CarouselOptions(
                      scrollDirection: Axis.horizontal,
                      height: 300,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        setState(() {
                          actIndex = index;
                        });
                      }),
                ),
                SizedBox(
                  height: 30,
                ),
                BuildIndicator(
                    actIndex: actIndex, count: product.imagesLink.length),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/viewvideo',
                        arguments: product);
                  },
                  child: ClipRRect(
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
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Click to See Videos",
                          style: TextStyle(
                              color: AppColors.color,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Product By Fashion Vella",
                  style: TextStyle(fontSize: 18, color: AppColors.color_lite),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      product.title,
                      // textAlign: TextAlign.left,
                      softWrap: true,
                      style: TextStyle(
                          color: AppColors.color,
                          fontSize: 40,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 25, top: 10),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      product.desc,
                      // textAlign: TextAlign.left,
                      softWrap: true,
                      style: TextStyle(
                          color: AppColors.color,
                          fontSize: 15,
                          fontWeight: FontWeight.normal),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CounterWidget(
                      initialValue: count,
                      key: UniqueKey(),
                      onChanged: (counts) => setState(() {
                        print(counts);
                        count = counts;
                      }),
                      limit: quantity,
                    ),
                    Text(
                      "Quantity : $quantity",
                      style: TextStyle(
                          fontSize: 30,
                          color: AppColors.color,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [...getWidgets()]),
                SizedBox(height: 20),
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
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Total :${count * product.price} Rs",
                        style: TextStyle(
                            color: AppColors.color,
                            fontSize: 40,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Rate This Product",
                  style: TextStyle(
                      color: AppColors.color,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                rating(
                  onchanged: (rati) => ratings = rati,
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: () {},
                  child: ClipRRect(
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
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Submit Rating",
                          style: TextStyle(
                              color: AppColors.color,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {},
                  child: ClipRRect(
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
                          "Buy Now",
                          style: TextStyle(
                              color: AppColors.color,
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageBuild extends StatelessWidget {
  String imageLink;
  ImageBuild({Key? key, required this.imageLink}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        child: Image(
          image: NetworkImage(
              "http://${port.portnumber}:3000/static/uploads/$imageLink"),
          // height: 400,
          fit: BoxFit.fill,
        ),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => PhotoView(
                imageProvider: NetworkImage(
                    "http://${port.portnumber}:3000/static/uploads/$imageLink")))),
      ),
    );
  }
}

class BuildIndicator extends StatefulWidget {
  late int actIndex;
  late int count;
  late BuildContext context;
  BuildIndicator(
      {Key? key, required this.actIndex, required this.count, required})
      : super(key: key);

  @override
  State<BuildIndicator> createState() => _BuildIndicatorState();
}

class _BuildIndicatorState extends State<BuildIndicator> {
  @override
  Widget build(BuildContext context) {
    widget.context = context;
    return AnimatedSmoothIndicator(
      duration: Duration(milliseconds: 100),
      activeIndex: widget.actIndex,
      count: widget.count,
      effect: SlideEffect(
          dotHeight: 10,
          radius: 30,
          dotColor: AppColors.color_lite,
          activeDotColor: AppColors.color),
    );
  }
}
