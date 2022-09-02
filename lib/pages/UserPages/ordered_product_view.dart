// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, must_be_immutable
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/counterwidget.dart';
import 'package:flutter_tst/utils/colors.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/menu/menu.dart';
import 'package:photo_view/photo_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OrderedPreview extends StatefulWidget {
  const OrderedPreview({Key? key}) : super(key: key);

  @override
  State<OrderedPreview> createState() => _OrderedPreviewState();
}

class _OrderedPreviewState extends State<OrderedPreview> {
  int actIndex = 0;
  int count = 1;
  int ratings = 0;
  late OverlayEntry floatingdropdown;
  late List<Widget> dropdowns = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                      ImageBuild(),
                  options: CarouselOptions(
                      scrollDirection: Axis.horizontal,
                      height: 300,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      onPageChanged: (index, reason) {
                        // print(BuildIndicators.runtimeType);

                        setState(() {
                          actIndex = index;
                        });
                      }),
                ),
                SizedBox(
                  height: 30,
                ),
                BuildIndicator(actIndex: actIndex, count: 5),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/videos');
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
                      "This Suit 1",
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
                      "This Suit 1 and you are going to buy and it will be amazing for you",
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
                      initialValue: 0,
                      onChanged: (counts) => setState(() {
                        count = counts;
                      }),
                      limit: 5,
                    ),
                    Text(
                      "Quantity : $count",
                      style: TextStyle(
                          fontSize: 18,
                          color: AppColors.color,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
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
                        "Total :900\$",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ImageBuild extends StatelessWidget {
  const ImageBuild({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        child: Image(
          image: AssetImage("./assets/images/data.jpg"),
          // height: 400,
          fit: BoxFit.fill,
        ),
        onTap: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => PhotoView(
                imageProvider: AssetImage("./assets/images/data.jpg")))),
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
