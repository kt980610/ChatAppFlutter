import 'dart:math';
import 'package:firebase_storage/firebase_storage.dart';
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
import 'package:housingapp/widgets/UserProfile.dart';
class database {
  database();
  List<searchTile> liste = [];
   search_user_by_mail(String mail) async {
     DocumentSnapshot ds1 = await FirebaseFirestore.instance.collection("Users").doc(mail).collection("kimlik").doc("email").get();
     DocumentSnapshot ds2 = await FirebaseFirestore.instance.collection("Users").doc(mail).collection("kimlik").doc("isim").get();
     DocumentSnapshot ds3 = await FirebaseFirestore.instance.collection("Users").doc(mail).collection("kimlik").doc("soyisim").get();


     String name = ds2.get("isim");
     String surname = ds3.get("soyisim");
     String email = ds1.get("email");
      print(name+ " NAME");


     searchTile tile = new searchTile(email, name, surname);
     liste.add(tile);
    // liste.add(u);
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
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messageCount").get();
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


    DocumentSnapshot ds = await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messageCount").get();
    int messagecount = ds.get("count");

    int count = messagecount+1;

    String date = DateTime.now().toString();
    await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messageCount").set({"count":count});
    await FirebaseFirestore.instance.collection(email).doc("chatroom").collection(Constants.myName).doc("messageCount").set({"count":count});
    await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc(count.toString()).set({"message":message_sent,"date":date,"sendby":Constants.myName});
    await FirebaseFirestore.instance.collection(email).doc("chatroom").collection(Constants.myName).doc(count.toString()).set({"message":message_sent,"date":date,"sendby":Constants.myName});

  }

 Future<void> getLastMessage(String email) async {

    List<messageTile> liste2 = [];
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messageCount").get();
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
      liste2.add(tile);
    }
    else {
      bool b = false;
      messageTile tile = new messageTile(date, sendby, message,b);
      liste2.add(tile);
    }
    liste2.addAll(Constants.messageList);
    Constants.messageList.clear();
    //liste2.sort((a,b) => a.date.compareTo(b.date));
    Constants.messageList.addAll(liste2);
    //liste2.addAll(liste.reversed);


  }
  void getMessages(String email) async {
    List<messageTile> liste2 = [];
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messageCount").get();
    int messagecount = ds.get("count");
   for (var i=messagecount;i>0;i--) {

     DocumentSnapshot ds2 = await FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc(i.toString()).get();
     String date = ds2.get("date");
     String message = ds2.get("message");
     String sendby = ds2.get("sendby");
     if(sendby==Constants.myName) {
       bool b = true;
       messageTile tile = new messageTile(date, sendby, message,b);
       liste2.add(tile);
     }
     else {
       bool b = false;
       messageTile tile = new messageTile(date, sendby, message,b);
       liste2.add(tile);
     }

   }
   Constants.messageList.addAll(liste2);
   print(liste.length.toString()+" SİZE");

  }

  void setUserList() async {
    Constants.userlist.clear();
    DocumentSnapshot ds5 = await FirebaseFirestore.instance.collection("userCount").doc("usercount").get();
    int usercount = ds5.get("count");
    DocumentSnapshot ds = await FirebaseFirestore.instance.collection("Users").doc(Constants.myName).collection("friends").doc("friends").get();
    List<dynamic> fl = ds.get("friends");
    Constants.friendlist.add(fl.elementAt(0).toString());
    for (var i=1;i<usercount+1;i++) {

      DocumentSnapshot ds6 =  await FirebaseFirestore.instance.collection("UsersV2").doc(i.toString()).get();
      String email = ds6.get("email");

      DocumentSnapshot ds1 = await FirebaseFirestore.instance.collection("Users").doc(email).collection("kimlik").doc("email").get();
      DocumentSnapshot ds2 = await FirebaseFirestore.instance.collection("Users").doc(email).collection("kimlik").doc("isim").get();
      DocumentSnapshot ds3 = await FirebaseFirestore.instance.collection("Users").doc(email).collection("kimlik").doc("soyisim").get();
      DocumentSnapshot ds4 = await FirebaseFirestore.instance.collection("Users").doc(email).collection("kimlik").doc("age").get();

      String name = ds2.get("isim");
      String surname = ds3.get("soyisim");
      //String email = ds1.get("email");
      int age = ds4.get("age");
      String name_surname = name+" "+surname;
      var url = await FirebaseStorage.instance.ref(email).getDownloadURL();
      String imgpath = url.toString();
      Userr u = new Userr(imgpath,name_surname,email,age);
      Constants.userlist.add(u);
        if(Constants.friendlist.contains(u.email)) {
          UserProfile up1 = new UserProfile(u.imagePath,u.nameSurname,u.age,true,"Özyeğin Üniversitesi","müzik film",0,u.email,true);
         // print(u.email+" auth");
          print("friend");
          Constants.profiles.add(up1);
        }
        else {
          UserProfile up2 = new UserProfile(u.imagePath,u.nameSurname,u.age,true,"Özyeğin Üniversitesi","müzik film",0,u.email,false);
          //print(u.email+" auth");
          print("not friend");
          Constants.profiles.add(up2);
        }

    }

  }
}
