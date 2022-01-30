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


  search_user_by_mail(String mail, List<UserNew> liste) async {
    UserNew u = new UserNew();
    await FirebaseFirestore.instance.collection("Users").doc(mail).collection("kimlik").doc("email").snapshots().listen((event) { Map<String, dynamic> data = event.data()!;
    u.setEmail(data['email']);
    });
    // You can then retrieve the value from the Map like this:
    FirebaseFirestore.instance.collection("Users").doc(mail).collection("kimlik").doc("isim").snapshots().listen((event) { Map<String, dynamic> data = event.data()!;
    u.setName(data['isim']); });
    FirebaseFirestore.instance.collection("Users").doc(mail).collection("kimlik").doc("soyisim").snapshots().listen((event) { Map<String, dynamic> data = event.data()!;
    u.setSurname(data['soyisim']); });
   //  userlist.add(u);
    liste.add(u);


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
  void addMessage(String message_sent, String email) async {
   // int message_count=0;
    ChatRoomInfo info = new ChatRoomInfo();
    try {
      String s = DateTime.now().toString();
      await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messageCount").snapshots().listen((event) {Map<String, dynamic>? data = event.data()!;
      int count = data["count"]+1;

      info.setCount(count);
      });
      await FirebaseFirestore.instance.collection(email).doc("chatroom").collection(Constants.myName).doc("messageCount").snapshots().listen((event) {Map<String, dynamic>? data = event.data()!;
      int count = data["count"]+1;

      info.setCount(count);
      //print(count.toString()+" COUNT");
      });
      await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messageCount").set({"count":info.message_count});
      await FirebaseFirestore.instance.collection(email).doc("chatroom").collection(Constants.myName).doc("messageCount").set({"count":info.message_count});
      await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc(info.message_count.toString()).set({"message":message_sent,"sendby":Constants.myName,"date":s});
      await FirebaseFirestore.instance.collection(email).doc("chatroom").collection(Constants.myName).doc(info.message_count.toString()).set({"message":message_sent,"sendby":Constants.myName,"date":s});
     /* await FirebaseFirestore.instance.collection("chatroom").doc(email+"_"+Constants.myName).collection("messagcount").doc("messagecount").snapshots().listen((event) {Map<String, dynamic>? data = event.data()!;
        info.setCount(data["count"]);});

      await FirebaseFirestore.instance.collection("chatroom").doc(email+"_"+Constants.myName).collection("messagecount").doc("messagecount").set({"count":info.message_count+1});
      await FirebaseFirestore.instance.collection("chatroom").doc(email+"_"+Constants.myName+"_"+s).collection("messages").doc((info.message_count+1).toString()).set({"date":s,"sendby":Constants.myName,"message":message_sent});
      await FirebaseFirestore.instance.collection("chatroom").doc(Constants.myName+"_"+email+"_"+s).collection("messages").doc((info.message_count+1).toString()).set({"date":s,"sendby":Constants.myName,"message":message_sent});

      this.getMessages(email, s);*/
      /*await FirebaseFirestore.instance.collection("chatroom").doc(Constants.myName+"_"+email+"_"+s).set({"date":s,"sendby": Constants.myName,"message":message_sent});
      await FirebaseFirestore.instance.collection("chatroom").doc(email+"_"+Constants.myName+"_"+s).set({"date":s,"sendby": Constants.myName,"message":message_sent});
      this.getMessages(email, s);*/
     // this.getMessages(email);
    }

    catch(e) {

    }
  }
  getLastMessage(String email) async {
    List<messageTile> liste = [];
    ChatRoomInfo info = new ChatRoomInfo();
    await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messageCount").snapshots().listen((event) {Map<String, dynamic>? data = event.data()!;
    info.setCount(data["count"]); });
    int k = info.message_count;
    message m = new message();
    await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc(k.toString()).snapshots().listen((event) {Map<String, dynamic>? data = event.data()!;
    m.setMessage(data["message"]);
    m.setSendBy(data["sendby"]);
    m.setDate(data["date"]);
    messageTile tile = new messageTile(m.date, m.sendby, m.mesaj);
    liste.add(tile); });
    return liste.last;
  }
  getMessages(String email) async {
   //message_list.clear();
    List<messageTile> liste = [];
    ChatRoomInfo info = new ChatRoomInfo();
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
   /* await FirebaseFirestore.instance.collection("chatroom").doc(email+"_"+Constants.myName+"_"+date).snapshots().listen((event) { Map<String, dynamic>? data = event.data()!;
    m.setDate(data['date']);
    m.setSendBy(data['sendby']);
    m.setMessage(data['message']);
    messageTile tile = new messageTile(m.date,m.sendby, m.mesaj);
    message_list.add(tile);*/
   await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messageCount").snapshots().listen((event) { Map<String, dynamic>? data = event.data()!;
   info.setCount(data["count"]); });
   for (var i=info.message_count;i>0;i--) {
     message m = new message();
     await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc(i.toString()).snapshots().listen((event) { Map<String, dynamic>? data = event.data()!;
     m.setMessage(data["message"]);
     m.setSendBy(data["sendby"]);
     m.setDate(data["date"]);
     messageTile tile = new messageTile(m.date, m.sendby, m.mesaj);
     liste.add(tile);
     });

    }

   return liste;



  }

}