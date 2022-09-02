// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tst/BLOC/categoryBloc/ApiLayer/category_model.dart';
// import 'package:flutter_tst/models/category.dart';
// import 'package:flutter_tst/models/category.dart';
import 'package:flutter_tst/utils/colors.dart';

class EditCategoryView extends StatefulWidget {
  final Category toshow;
  const EditCategoryView({Key? key, required this.toshow}) : super(key: key);

  @override
  State<EditCategoryView> createState() => _EditCategoryViewState();
}

class _EditCategoryViewState extends State<EditCategoryView> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10, bottom: 8, top: 6),
              child: Text(
                '${widget.toshow.categoryName}',
                style: TextStyle(
                    color: AppColors.color,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        )
      ],
    );
  }
}
