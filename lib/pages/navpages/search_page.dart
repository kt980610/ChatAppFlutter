import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housingapp/constants/colors.dart';
import 'package:housingapp/widgets/UserProfile.dart';
import 'package:housingapp/constants/currentUser.dart';
import 'package:housingapp/services/database.dart';
class SearchPage extends StatelessWidget {

  //List<Widget> profiles = []; // [UserProfile("img/welcome-one.png", "kerem tuna",23,true,"Özyeğin Üniversitesi","müzik film",0,"kerem.tuna@windowslive.com",true),UserProfile("img/hiking.png", "emin kartcı",22,true,"Özyeğin Üniversitesi","bilim müzik kitap",1,"emin@gmail.com",false)];
  SearchPage();
  @override
  Widget build(BuildContext context) {

    //print(Constants.profiles.length.toString()+" = LENGTH");
   return Scaffold(backgroundColor: Colors.white70,
      appBar: AppBar(title: Text("kullanıcılar",),backgroundColor: Colors.green,),
      body: Center(
        child: PageView(children: Constants.profiles),
      ),
    );
  }
}
