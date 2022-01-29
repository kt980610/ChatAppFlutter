import 'package:flutter/cupertino.dart';
import 'package:housingapp/widgets/UserProfile.dart';
class MyPage extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MyProfile("Kerem Tuna", "img/welcome-one.png",23,true,"Özyeğin Üniversitesi","müzik film",0);
  }
}
