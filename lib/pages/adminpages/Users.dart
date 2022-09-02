// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/menu/menu.dart';
import 'package:flutter_tst/Widgets/sellerpage_widgets/user_name_role_widget/username_role_tile.dart';
import 'package:flutter_tst/utils/colors.dart';

class Users extends StatefulWidget {
  Users({Key? key}) : super(key: key);

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
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
        child: Column(
          children: [
            SizedBox(
              height: 16,
            ),
            AppMenu(
              menu: true,
              home: true,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              "All Users",
              style: TextStyle(
                  color: AppColors.color,
                  fontWeight: FontWeight.bold,
                  fontSize: 30),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Name",
                  style: TextStyle(
                      color: AppColors.color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  "Role",
                  style: TextStyle(
                      color: AppColors.color,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 15,
                  itemBuilder: (context, index) {
                    return UserNameRole();
                  }),
            )
          ],
        ),
      ),
    ));
  }
}
