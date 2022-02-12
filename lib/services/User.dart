import 'package:flutter/material.dart';
class message {
  String date = "";
  String sendby = "";
  String mesaj = "";
  message();
  void setDate(String date1) {
    this.date = date1;
  }
  void setSendBy(String sendby1) {
    this.sendby=sendby1;
  }
  void setMessage(String mesaj1) {
    this.mesaj=mesaj1;
  }


}
class User {
  String nameSurname;
  String email_adress;
  String about;
  User(this.nameSurname,this.email_adress,this.about);


}