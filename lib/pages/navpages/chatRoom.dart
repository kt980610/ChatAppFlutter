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
  int messagecount;
  chatRoom(this.email,this.messagecount);

  @override
  _chatRoomState createState() => _chatRoomState(this.email,this.messagecount);
}
ChatRoomInfo info = new ChatRoomInfo();
//database db = new database();

class _chatRoomState extends State<chatRoom> {

  int messagecount;
  String message_sent = "";
 late String email;



  _chatRoomState(this.email,this.messagecount);

  //List<messageTile> message_list1 = db.getMessages(this.email);
  String s = "";

  @override
  Widget build(BuildContext context) {
    Constants.db.getMessageCount(this.messagecount,this.email);
    Constants.db.getMessages(this.email);
    if(this.messagecount>Constants.messageList.length) {
      Constants.db.getLastMessage(this.email);
      List<messageTile> list2 = [];
      list2.addAll(Constants.messageList);
      Constants.messageList.clear();
    print("last message came");
    setState(() {
      Constants.messageList.addAll(list2);
  });
  }
    return Scaffold(
      appBar: AppBar(leading: roundedImage('img/welcome-one.png',10),title: Text(this.email),backgroundColor: Colors.green,),
      body: Stack(children: [ ListView(dragStartBehavior: DragStartBehavior.down,children: Constants.messageList,reverse: true,),SizedBox(child: Container(),),
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
                onTap: () async {

                  Constants.db.addMessage(message_sent, this.email);
                  await Constants.db.getLastMessage(this.email);
                  List<messageTile> list3 = [];
                  list3.addAll(Constants.messageList);
                  Constants.messageList.clear();
                      setState(() {

                            Constants.messageList.addAll(list3);





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
