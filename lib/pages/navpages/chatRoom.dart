import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:housingapp/pages/LoginPage.dart';
import 'package:housingapp/services/User.dart';
import 'package:housingapp/services/database.dart';
import 'package:housingapp/pages/navpages/bar_item_page.dart';
import 'package:housingapp/constants/currentUser.dart';
class chatRoom extends StatefulWidget {
  String email;
  List<messageTile> liste;
  chatRoom(this.email,this.liste);

  @override
  _chatRoomState createState() => _chatRoomState(this.email,this.liste);
}
ChatRoomInfo info = new ChatRoomInfo();
List<messageTile> message_list = [];
database db = new database();
class _chatRoomState extends State<chatRoom> {
  List<messageTile> liste = [];
 late String email;
  String message_sent = "";

  _chatRoomState(this.email,this.liste);

  //List<messageTile> message_list1 = db.getMessages(this.email);
  String s = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(leading: roundedImage('img/welcome-one.png',10),title: Text(this.email),backgroundColor: Colors.green,),
      body: Stack(children: [ ListView(children: this.liste,reverse: true,),
        Container(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),alignment: Alignment.bottomCenter,
          child: Row(crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: TextField(onSubmitted: (value) {
                message_sent = value;
              },
                onChanged: (value) {
                  message_sent = value;
                },
                decoration: InputDecoration(
                    hintText: "Mesaj"),)),
              GestureDetector(child: Container(
                child: Icon(Icons.send), height: 40, width: 40,),
                onTap: () {
               //db.incrementMessageCount(email);
                   FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messageCount").snapshots().listen((event) {
                    Map<String, dynamic>? data = event.data()!;
                    int count = data["count"];
                    info.setCount(count);
                    print(info.message_count.toString()+" COUNT1");
                    setState(() {
                       FirebaseFirestore.instance.collection(email).doc("chatroom").collection(Constants.myName).doc("messageCount").set({"count": info.message_count});
                       FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messageCount").set({"count": info.message_count});

                      /* db.addMessage(message_sent, this.email);
                     messageTile newtile = db.getLastMessage(this.email);
                     this.liste.add(newtile);*/
                      // ChatRoomInfo info = new ChatRoomInfo();
                      FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messageCount").snapshots().listen((event) {
                        Map<String, dynamic>? data = event.data()!;
                        FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc(info.message_count.toString()).set({"message":message_sent,"sendby":Constants.myName,"date":s});
                      }) ;
                      FirebaseFirestore.instance.collection(email).doc("chatroom").collection(Constants.myName).doc("messageCount").snapshots().listen((event) {
                        Map<String, dynamic>? data = event.data()!;
                        FirebaseFirestore.instance.collection(email).doc("chatroom").collection(Constants.myName).doc(info.message_count.toString()).set({"message":message_sent,"sendby":Constants.myName,"date":s});
                      }) ;
                      List<messageTile> liste = [];
                     // ChatRoomInfo info = new ChatRoomInfo();
                      FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messageCount").snapshots().listen((event) {Map<String, dynamic>? data = event.data()!;
                      info.setCount(data["count"]);
                      int k = info.message_count;
                      message m = new message();
                      FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc(k.toString()).snapshots().listen((event) {Map<String, dynamic>? data = event.data()!;
                      m.setMessage(data["message"]);
                      m.setSendBy(data["sendby"]);
                      m.setDate(data["date"]);
                      messageTile tile = new messageTile(m.date, m.sendby, m.mesaj);
                      this.liste.add(tile); });


                      });
                  });
                 // db.addMessage(message_sent, this.email);
                   // db.addMessage(message_sent, this.email);
                  /*  setState(() {

                     /* db.addMessage(message_sent, this.email);
                     messageTile newtile = db.getLastMessage(this.email);
                     this.liste.add(newtile);*/
                     // ChatRoomInfo info = new ChatRoomInfo();

                      List<messageTile> liste = [];
                      ChatRoomInfo info = new ChatRoomInfo();
                      FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messageCount").snapshots().listen((event) {Map<String, dynamic>? data = event.data()!;
                      info.setCount(data["count"]);
                      int k = info.message_count;
                      message m = new message();
                      FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc(k.toString()).snapshots().listen((event) {Map<String, dynamic>? data = event.data()!;
                      m.setMessage(data["message"]);
                      m.setSendBy(data["sendby"]);
                      m.setDate(data["date"]);
                      messageTile tile = new messageTile(m.date, m.sendby, m.mesaj);
                      this.liste.add(tile); });


                      });*/



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


                      });
                       // db.addMessage(message_sent, this.email);
                       /* message_list1.clear();
                        message_list1.addAll(message_list);
                        print(message_list1.length.toString()+" SİZE");*/
                        //message_list1.clear();
                       // message_list1.addAll(message_list);
                   // });




                },),
            ],
          ),),
       ], ),


    );
  }
}
class ChatRoomInfo {
  late int message_count;
  ChatRoomInfo();
  setCount(int message_count) {
    this.message_count=message_count;
  }
}
