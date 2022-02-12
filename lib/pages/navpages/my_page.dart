import 'package:flutter/cupertino.dart';
import 'package:housingapp/constants/currentUser.dart';
import 'package:housingapp/widgets/UserProfile.dart';
class MyPage extends StatelessWidget {


  MyPage();
  @override
  Widget build(BuildContext context) {
    return updatedMyProfile("Kerem Tuna",Constants.myName,);//MyProfile("Kerem Tuna", "img/welcome-one.png",23,true,"Özyeğin Üniversitesi","müzik film",0);
  }
}
