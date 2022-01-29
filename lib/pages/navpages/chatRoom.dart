import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housingapp/pages/LoginPage.dart';
import 'package:housingapp/services/User.dart';
import 'package:housingapp/services/database.dart';
import 'package:housingapp/pages/navpages/bar_item_page.dart';
class chatRoom extends StatefulWidget {
  String email;
  chatRoom(this.email);

  @override
  _chatRoomState createState() => _chatRoomState(this.email);
}

List<messageTile> message_list = [];
database db = new database();
class _chatRoomState extends State<chatRoom> {

  String email;
  String message_sent = "";

  _chatRoomState(this.email);


  String s = "";
  List<messageTile> message_list1 = message_list;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(leading: roundedImage('img/welcome-one.png',10),title: Text(this.email),backgroundColor: Colors.green,),
      body: Stack(children: [ ListView(children: message_list1,),
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
                    db.addMessage(message_sent, this.email);
                    setState(() {
                        db.addMessage(message_sent, this.email);
                        message_list1.clear();
                        message_list1.addAll(message_list);
                        print(message_list1.length.toString()+" SİZE");
                        //message_list1.clear();
                       // message_list1.addAll(message_list);
                    });




                },),
            ],
          ),),
       ], ),


    );
  }
}
class ChatRoomInfo {
  late int message_count;

  setCount(int message_count) {
    this.message_count=message_count;
  }
}
