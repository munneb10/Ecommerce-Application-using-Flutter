// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_tst/utils/colors.dart';

class SellerProductTile extends StatefulWidget {
  const SellerProductTile({Key? key}) : super(key: key);

  @override
  State<SellerProductTile> createState() => _SellerProductTileState();
}

class _SellerProductTileState extends State<SellerProductTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
            child: Row(
              children: [
                ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                        width: 100,
                        height: 160,
                        child: Image.asset(
                          './assets/images/data.jpg',
                          fit: BoxFit.fill,
                        ))),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            "Suit 1",
                            style: TextStyle(
                                color: AppColors.color,
                                fontSize: 30,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Text(
                            "This is Suit 1 and you are...",
                            style: TextStyle(
                                color: AppColors.color_lite,
                                fontSize: 15,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text("Attributes : Size | Color | Weight",
                            style: TextStyle(
                                color: AppColors.color,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Row(
                            children: [
                              Text(
                                "Quantity : 3",
                                style: TextStyle(
                                    color: AppColors.color,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Text(
                                "Price : 900\$",
                                style: TextStyle(
                                    color: AppColors.color,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Edit",
                                style: TextStyle(
                                    color: AppColors.color,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Delete",
                                style: TextStyle(
                                    color: AppColors.color,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
