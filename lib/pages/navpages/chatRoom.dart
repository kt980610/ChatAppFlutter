import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
  int messagecount;
  chatRoom(this.email,this.liste,this.messagecount);

  @override
  _chatRoomState createState() => _chatRoomState(this.email,this.liste,this.messagecount);
}
ChatRoomInfo info = new ChatRoomInfo();
List<messageTile> message_list = [];
database db = new database();

class _chatRoomState extends State<chatRoom> {
  List<messageTile> liste = [];
  int messagecount;
  String message_sent = "";
 late String email;



  _chatRoomState(this.email,this.liste,this.messagecount);

  //List<messageTile> message_list1 = db.getMessages(this.email);
  String s = "";

  @override
  Widget build(BuildContext context) {
    db.getMessageCount(this.messagecount,this.email);
    //db.getMessages(this.email,this.liste);
    if(this.messagecount>this.liste.length) {
      setState(() {
        db.getLastMessage(this.email, this.liste);
        //print("last message came");
      });
    }
    return Scaffold(
      appBar: AppBar(leading: roundedImage('img/welcome-one.png',10),title: Text(this.email),backgroundColor: Colors.green,),
      body: Stack(children: [ ListView(dragStartBehavior: DragStartBehavior.down,children: this.liste,reverse: true,),SizedBox(child: Container(),),
        Container(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),alignment: Alignment.bottomCenter,
          child: Row(crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: TextField( onSubmitted: (value) {
                message_sent = value;

              },
                onChanged: (value) {
                  message_sent = value;

                },
                decoration: InputDecoration(
                    hintText: "Mesaj"),),),
              GestureDetector(child: Container(
                child: Icon(Icons.send), height: 40, width: 40,),
                onTap: () {

                      setState(() {
                        db.addMessage(message_sent, this.email);
                        db.getLastMessage(this.email, this.liste);







                },); },),
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
