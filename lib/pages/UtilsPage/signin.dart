// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/button.dart';
import 'package:flutter_tst/Widgets/Utility_Widgets/input.dart';
import 'package:flutter_tst/utils/colors.dart';
import 'package:flutter_tst/utils/host.dart';
import 'package:flutter_tst/utils/secure_storage.dart';
import 'package:http/http.dart' as http;

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  String username = "";
  String password = "";
  String errorMessage = "";
  bool iserror = false;
  bool isSigning = false;
  String onSignin = "";
  void checkandSignin() {
    if (isSigning == true) {
      iserror = true;
      errorMessage = "Please Wait we are Signing in";
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
        isSigning = true;
        iserror = false;
        signIn();
      });
    }
  }

  void signIn() async {
    var url = Uri.parse('http://${port.portnumber}:3000/user/adduser');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        'username': username,
        'password': password,
      }),
    );
    Map<String, dynamic> userInfo = jsonDecode(response.body);
    if (response.statusCode != 200) {
      iserror = true;
      isSigning = false;
      onSignin = "";
      errorMessage =
          "Error : Try with the different username or try again later";
      setState(() {});
      return;
    }
    UserStorage.write("userid", userInfo['userId']);
    setState(() {
      isSigning = false;
      onSignin = "SUCCESSFULLY SIGNED IN";
      Future.delayed(Duration(milliseconds: 1300), () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/AllProducts', (Route<dynamic> route) => false);
      });
    });
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
                "Sign In",
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
                  onchange: (value) => username = value),
              SizedBox(
                height: 30,
              ),
              Input_box(
                  textfieldvalue: "Password",
                  onchange: (value) => password = value),
              SizedBox(
                height: 30,
              ),
              Button(buttonValue: "Sign In", onclick: checkandSignin),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  "Terms and Conditions",
                  style: TextStyle(
                      fontSize: 20,
                      decoration: TextDecoration.underline,
                      decorationThickness: 3,
                      color: AppColors.color,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 15),
              isSigning
                  ? Column(
                      children: [
                        CircularProgressIndicator(
                          color: AppColors.fore_background_begin,
                          backgroundColor: AppColors.base_background_end,
                        ),
                        SizedBox(height: 10),
                        Text("Signing in",
                            style: TextStyle(
                                fontSize: 12,
                                color: AppColors.color,
                                fontWeight: FontWeight.bold))
                      ],
                    )
                  : Text(onSignin,
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
