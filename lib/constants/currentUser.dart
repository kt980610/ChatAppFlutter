import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housingapp/services/database.dart';
import 'package:housingapp/pages/navpages/bar_item_page.dart';
class Constants{

  static String myName = "";
  static String imgpath = "";
  static database db = new database();
  static List<messageTile> messageList = [];
  static List<String> friendlist = [];
  static List<Userr> userlist = [];
  static List<Widget> profiles = [];
}


class Userr {
  String imagePath;
  String nameSurname;
  String email;
 // String uni;
  int age;
  Userr(this.imagePath,this.nameSurname,this.email,this.age);





}