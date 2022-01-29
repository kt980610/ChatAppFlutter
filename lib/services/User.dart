import 'package:flutter/material.dart';
class UserNew {
  String email = "";
  String name = "";
  String surname = "";
  UserNew();
  void setName(String name1) {
    this.name = name1;
  }
  void setSurname(String surname1) {
    this.surname= surname1;
  }
  void setEmail(String email1) {
    this.email=email1;
  }


}

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