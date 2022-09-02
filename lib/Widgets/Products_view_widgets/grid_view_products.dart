// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_tst/BLOC/productBloc/ApiLayer/api_model.dart';
import 'package:flutter_tst/utils/colors.dart';
import 'package:flutter_tst/utils/host.dart';

class Products_view extends StatelessWidget {
  ApiModel product;
  Products_view({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (() {
        Navigator.pushNamed(context, '/previewProduct', arguments: product);
      }),
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
          child: Column(
            children: [
              ClipRRect(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    "http://${port.portnumber}:3000/static/uploads/${product.imagesLink[0]}",
                    fit: BoxFit.fill,
                    height: 130,
                  ),
                ),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        product.title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            color: AppColors.color,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 0,
                    child: Row(
                      children: [
                        Text(
                          "4.5",
                          style: TextStyle(
                              color: AppColors.color,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.star_rate_rounded,
                          color: AppColors.color,
                          size: 25,
                        )
                      ],
                    ),
                  )
                ],
              ),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Container(
                    child: Text(
                      product.desc,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: AppColors.color),
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Text(
                      "${product.price} Rs",
                      style: TextStyle(
                          color: AppColors.color,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    product.quantity > 0 ? "In Stock" : "No Stock",
                    style: TextStyle(
                        color: AppColors.color,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
