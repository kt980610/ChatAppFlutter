import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:housingapp/constants/currentUser.dart';
import 'package:housingapp/pages/navpages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housingapp/pages/LoginPage.dart';
import 'package:housingapp/services/User.dart';
import 'package:housingapp/services/auth.dart';
import 'package:housingapp/pages/navpages/bar_item_page.dart';
import 'package:housingapp/pages/navpages/chatRoom.dart';
class database {
  database();
   search_user_by_mail(String mail,List<UserNew> liste) async {
     DocumentSnapshot ds = await FirebaseFirestore.instance.collection("Users2").doc(mail).get();
     String name = ds.get("isim");
     String surname = ds.get("soyisim");
     String email = ds.get("email");


     UserNew u = new UserNew();
     u.setEmail(email);
     u.setName(name);
     u.setSurname(surname);
     liste.add(u);
     // DocumentReference docref = FirebaseFirestore.instance.collection("Users").

   
     /* FirebaseFirestore.instance.collection("Users").doc(mail).collection(
          "kimlik").doc("email").snapshots().listen((event) {
        Map<String, dynamic> data = event.data()!;
        u.setEmail(data['email']);
      });
      // You can then retrieve the value from the Map like this:
      FirebaseFirestore.instance.collection("Users").doc(mail).collection(
          "kimlik").doc("isim").snapshots().listen((event) {
        Map<String, dynamic> data = event.data()!;
        u.setName(data['isim']);
      });
      FirebaseFirestore.instance.collection("Users").doc(mail).collection(
          "kimlik").doc("soyisim").snapshots().listen((event) {
        Map<String, dynamic> data = event.data()!;
        u.setSurname(data['soyisim']);

      });*/
     /* FirebaseFirestore.instance.collection("Users2").doc(mail).snapshots().listen((event) {
        Map<String, dynamic> data = event.data()!;
        u.setEmail(data['email']);
        u.setName(data['isim']);
        u.setSurname(data['soyisim']);
        liste.add(u);
      });
      */
      //return u;
      //print(u.email+" EMAİL");


   //  userlist.add(u);
   // liste.add(u);



  }

  void create_chatroom(String email) async{
    await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messageCount").set({"count":0});
    print(Constants.myName+" MYNAME");
    print(email+" EMAİL");
    await FirebaseFirestore.instance.collection(email).doc("chatroom").collection(Constants.myName).doc("messageCount").set({"count":0});
    //info.setCount(0);
    //await FirebaseFirestore.instance.collection("chatroom").doc(email+"_"+Constants.myName).collection("messagecount").doc("messagecount").set({"count":0});
   // await FirebaseFirestore.instance.collection("chatroom").doc(Constants.myName+"_"+email).collection("messagecount").doc("messagecount").set({"count":0});
   // await FirebaseFirestore.instance.collection("chatroom").doc(Constants.myName+"_"+email).set({"count":0});
  }
  /*void addnewMessage(String email,String s,int message_count, String message_sent) async {
    await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messageCount").set({"count":message_count});
    await FirebaseFirestore.instance.collection(email).doc("chatroom").collection(Constants.myName).doc("messageCount").set({"count":message_count});
    await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc(message_count.toString()).set({"message":message_sent,"sendby":Constants.myName,"date":s});
    await FirebaseFirestore.instance.collection(email).doc("chatroom").collection(Constants.myName).doc(message_count.toString()).set({"message":message_sent,"sendby":Constants.myName,"date":s});

  }*/
  void getMessageCount(int count, String email) async {
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messagecount").get();
    int count = ds.get("count");
  }
  void incrementMessageCount(String email) async {

   // FirebaseFirestore.instance.collection(collectionPath)
   // FirebaseFirestore.instance.collection(email).doc("chatroom").collection(Constants.myName).doc("messageCount").set({"count": count});
   /* await FirebaseFirestore.instance.collection(email).doc("chatroom").collection(Constants.myName).doc("messageCount").snapshots().listen((event) {Map<String, dynamic>? data = event.data()!;
    int count = data["count"]+1;
    //FirebaseFirestore.instance.collection(email).doc("chatroom").collection(Constants.myName).doc("messageCount").set({"count": count});
    });*/
    await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messageCount").snapshots().listen((event) {
      Map<String, dynamic>? data = event.data()!;
      int count = data["count"] + 1;
      info.setCount(count);
      print(info.message_count.toString()+" COUNT1");
    });
    print(info.message_count.toString()+" COUNT");
   await FirebaseFirestore.instance.collection(email).doc("chatroom").collection(Constants.myName).doc("messageCount").set({"count": info.message_count});
   await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messageCount").set({"count": info.message_count});

  }
  void addMessage(String message_sent, String email) async {


    DocumentSnapshot ds = await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messagecount").get();
    int messagecount = ds.get("count");

    int count = messagecount+1;

    String date = DateTime.now().toString();
    await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messagecount").set({"count":count});
    await FirebaseFirestore.instance.collection(email).doc("chatroom").collection(Constants.myName).doc("messagecount").set({"count":count});
    await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc(count.toString()).set({"message":message_sent,"date":date,"sendby":Constants.myName});
    await FirebaseFirestore.instance.collection(email).doc("chatroom").collection(Constants.myName).doc(count.toString()).set({"message":message_sent,"date":date,"sendby":Constants.myName});

  }
 void getLastMessage(String email,List<messageTile> liste) async {
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messagecount").get();
    int messagecount = ds.get("count");
    DocumentSnapshot ds2 = await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc(messagecount.toString()).get();
    String date = ds2.get("date");
    String message = ds2.get("message");
    String sendby = ds2.get("sendby");
    print(date+" date");
    print(sendby+" sendby");
    print(message+" mesaj");
    if(sendby==Constants.myName) {
      bool b = true;
      messageTile tile = new messageTile(date, sendby, message,b);
      liste.add(tile);
    }
    else {
      bool b = false;
      messageTile tile = new messageTile(date, sendby, message,b);
      liste.add(tile);
    }

  }
  getMessages(String email,List<messageTile> liste) async {
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messagecount").get();
    int messagecount = ds.get("count");
   for (var i=messagecount;i>0;i--) {

     DocumentSnapshot ds2 = await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc(i.toString()).get();
     String date = ds2.get("date");
     String message = ds2.get("message");
     String sendby = ds2.get("sendby");
     if(sendby==Constants.myName) {
       bool b = true;
       messageTile tile = new messageTile(date, sendby, message,b);
       liste.add(tile);
     }
     else {
       bool b = false;
       messageTile tile = new messageTile(date, sendby, message,b);
       liste.add(tile);
     }

   }
   print(liste.length.toString()+" SİZE");

  }

}