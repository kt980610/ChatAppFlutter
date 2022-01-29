//import 'dart:html';
import 'package:housingapp/pages/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housingapp/constants/colors.dart';

class ResponsiveButton extends StatelessWidget {

  bool? isResponsive;
  double? width;

  ResponsiveButton({Key? key,
    this.width,
    this.isResponsive = false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(child: Container(
      width: this.width,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
       //color: AppColors.mainColor
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Sign in"),
          //Image.asset("img/button-one.png",width: this.width)
        ],
      ),
    ),onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()),);},);
  }
}
