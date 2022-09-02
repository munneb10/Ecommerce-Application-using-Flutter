// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/button.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/input.dart';
import 'package:flutter_tst/utils/colors.dart';
import 'package:flutter_tst/utils/host.dart';
import 'package:flutter_tst/utils/secure_storage.dart';
import 'package:http/http.dart' as http;

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String username = "";
  String password = "";
  String errorMessage = "";
  bool iserror = false;
  bool islogging = false;
  String onlogin = "";
  void checkandlogin() {
    if (islogging == true) {
      iserror = true;
      errorMessage = "Please Wait we are logging in";
      setState(() {});
      return;
    }
    if (username == "") {
      iserror = true;
      errorMessage = "Please Enter the Username";
      setState(() {});
    } else if (password == "") {
      iserror = true;
      errorMessage = "Please Enter the Password";
      setState(() {});
    } else {
      setState(() {
        FocusScope.of(context).unfocus();
        islogging = true;
        iserror = false;
        login();
      });
    }
  }

  void login() async {
    var url = Uri.parse(
        'http://${port.portnumber}:3000/user/authuser?username=$username&password=$password');
    final response = await http.get(url);
    // if (response.body == "") {
    //   print("No User");
    // }
    Map<String, dynamic> userInfo = jsonDecode(response.body);
    if (response.statusCode == 200) {
      UserStorage.write("userid", userInfo['_id']);
      setState(() {
        islogging = false;
        iserror = false;
        onlogin = "SUCCESSFULLY LOGED IN";
        Future.delayed(Duration(milliseconds: 1300), () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/AllProducts', (Route<dynamic> route) => false);
        });
      });
    } else {
      iserror = true;
      islogging = false;
      onlogin = "";
      errorMessage = "Error : Details Are Invalid Try Again";
      setState(() {});
    }
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
            children: [
              SizedBox(
                height: 180,
              ),
              Text(
                "Log In",
                style: TextStyle(
                    fontSize: 50,
                    color: AppColors.color,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              iserror
                  ? Text(errorMessage,
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColors.color,
                          fontWeight: FontWeight.bold))
                  : Container(),
              Input_box(
                textfieldvalue: "Username",
                onchange: (value) => username = value,
              ),
              SizedBox(
                height: 30,
              ),
              Input_box(
                  textfieldvalue: "Password",
                  onchange: (value) => password = value),
              SizedBox(
                height: 30,
              ),
              Button(buttonValue: "Login", onclick: checkandlogin),
              SizedBox(
                height: 30,
              ),
              SizedBox(height: 15),
              islogging
                  ? Column(
                      children: [
                        CircularProgressIndicator(
                          color: AppColors.fore_background_begin,
                          backgroundColor: AppColors.base_background_end,
                        ),
                        SizedBox(height: 10),
                        Text("logging in",
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.color,
                                fontWeight: FontWeight.bold))
                      ],
                    )
                  : Text(onlogin,
                      style: TextStyle(
                          fontSize: 12,
                          color: AppColors.color,
                          fontWeight: FontWeight.bold))
            ],
          ),
        ),
      ),
    ));
  }
}
