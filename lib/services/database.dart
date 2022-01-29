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
  ChatRoomInfo info = new ChatRoomInfo();
  UserNew u = new UserNew();
  search_user_by_mail(String mail) async {

    await FirebaseFirestore.instance.collection("Users").doc(mail).collection("kimlik").doc("email").snapshots().listen((event) { Map<String, dynamic> data = event.data()!;
    u.setEmail(data['email']);
    });
    // You can then retrieve the value from the Map like this:
    FirebaseFirestore.instance.collection("Users").doc(mail).collection("kimlik").doc("isim").snapshots().listen((event) { Map<String, dynamic> data = event.data()!;
    u.setName(data['isim']); });
    FirebaseFirestore.instance.collection("Users").doc(mail).collection("kimlik").doc("soyisim").snapshots().listen((event) { Map<String, dynamic> data = event.data()!;
    u.setSurname(data['soyisim']); });
    userlist.add(u);


  }

  void create_chatroom(String email) async{
    info.setCount(0);
    await FirebaseFirestore.instance.collection("chatroom").doc(email+"_"+Constants.myName).collection("messagecount").doc("messagecount").set({"count":0});
    await FirebaseFirestore.instance.collection("chatroom").doc(Constants.myName+"_"+email).collection("messagecount").doc("messagecount").set({"count":0});
  }
  void addMessage(String message_sent, String email) async {
   // int message_count=0;
    try {
      String s = DateTime.now().toString();

      await FirebaseFirestore.instance.collection("chatroom").doc(email+"_"+Constants.myName).collection("messagcount").doc("messagecount").snapshots().listen((event) {Map<String, dynamic>? data = event.data()!;
        info.setCount(data["count"]);});

      await FirebaseFirestore.instance.collection("chatroom").doc(email+"_"+Constants.myName).collection("messagecount").doc("messagecount").set({"count":info.message_count+1});
      await FirebaseFirestore.instance.collection("chatroom").doc(email+"_"+Constants.myName+"_"+s).collection("messages").doc((info.message_count+1).toString()).set({"date":s,"sendby":Constants.myName,"message":message_sent});
      await FirebaseFirestore.instance.collection("chatroom").doc(Constants.myName+"_"+email+"_"+s).collection("messages").doc((info.message_count+1).toString()).set({"date":s,"sendby":Constants.myName,"message":message_sent});

      this.getMessages(email, s);
    }
    catch(e) {

    }
  }
 void getMessages(String email,String date) async {
   message m = new message();
   //String date = DateTime.now().toString();

   /*await FirebaseFirestore.instance.collection("chatroom").orderBy(false).snapshots().listen((event) {
     QuerySnapshot<Map<String, dynamic>> data = event;
      for(var i=0;i<event.docs.length;i++) {
        print(event.docs.length.toString()+" MESSAGE COUNT");
     //message m = new message();
        Map<String,dynamic> map = event.docs.elementAt(i).data();
     m.setDate(map['date']);
     m.setSendBy(map['sendby']);
     m.setMessage(map['message']);
     messageTile tile = new messageTile(m.date, m.sendby, m.mesaj);
     message_list.add(tile);
   }
    });*/
    await FirebaseFirestore.instance.collection("chatroom").doc(email+"_"+Constants.myName+"_"+date).snapshots().listen((event) { Map<String, dynamic>? data = event.data()!;
    m.setDate(data['date']);
    m.setSendBy(data['sendby']);
    m.setMessage(data['message']);
    messageTile tile = new messageTile(m.date,m.sendby, m.mesaj);
    message_list.add(tile);

    });



  }
}