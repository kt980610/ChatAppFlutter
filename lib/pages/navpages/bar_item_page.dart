import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:housingapp/constants/currentUser.dart';
import 'package:housingapp/services/User.dart';
import 'package:housingapp/services/database.dart';
import 'package:housingapp/widgets/UserProfile.dart';
import 'package:housingapp/pages/navpages/chatRoom.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_1.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_10.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_3.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_5.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_6.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_7.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_8.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_9.dart';
class BarItemPage extends StatelessWidget {
  const BarItemPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
            "Bar Item Page"
        ),
      ),
    );
  }
}
List<searchTile> tileList = [];

class userSearch extends StatefulWidget {
  const userSearch({Key? key}) : super(key: key);

  @override
  _userSearchState createState() => _userSearchState();
}

//Widget w = Container();

class _userSearchState extends State<userSearch> {
  database db = new database();
  String email = "";
  Widget w = Container();
  //List<searchTile> liste = [];
  @override
  Widget build(BuildContext context)  {

      return Scaffold(
        appBar: AppBar(title: Text("Ara"), backgroundColor: Colors.green,),
        body: Container(child: Column(children: [
          Container(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Row(
              children: [
                Expanded(child: TextField(onSubmitted: (value) {
                  email = value;
                },
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: InputDecoration(
                      hintText: "Kullanıcı email'ı girin"),)),
                GestureDetector(child: Container(
                  child: Icon(Icons.search), height: 40, width: 40,),
                  onTap: () {
                     //liste.clear();
                    db.search_user_by_mail(email);

                   // print(liste.last.email+ " EMAİL");
                   /*  List<UserNew> liste2 = [];
                    db.search_user_by_mail(email, liste2);*/
                    setState(()  {


                     w = db.liste.last;

                     // print(data['email']);


                      //liste.clear();
                      //db.create_chatroom(email);
                      //db.addMessage("message", email);
                     // FutureBuilder f=db.search_user_by_mail(email);
                     // Widget w=db.search_user_by_mail(email);
    //db.search_user_by_mail(email,liste);

                      //UserNew u = liste.last;
                     // print(liste.length.toString()+ " SİZE");
                      //searchTile tile = new searchTile(
                          //u.email,u.name,u.surname);
                      //liste.add(tile);
                    /*  liste.clear();
                      liste.add(tile);
                      w=liste.last;*/
                     // w = tile;
                     // w = tile;
                    });
                  },),
              ],
            ),),
        w,],),),
      );


  }
}
class searchTile extends StatelessWidget {
  String email;
  String name;
  String surname;
  int messagecount=0;
  searchTile(this.email,this.name,this.surname);
  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(10),color: Colors.lightGreen, alignment:Alignment.center, child: Row(children: [Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text(this.email,style: TextStyle(color: Colors.black),),Text(this.name,style: TextStyle(color: Colors.black)),Text(this.surname,style: TextStyle(color: Colors.black)), ],),Spacer(),IconButton(onPressed: () {
      //List<messageTile> liste2 = [];
      Constants.messageList.clear();
      Constants.db.getMessages(this.email);
      this.messagecount=Constants.messageList.length;
      //print(liste2.length.toString()+" SİZE");
      Navigator.push(context, MaterialPageRoute(builder: (context) => chatRoom(email, this.messagecount)),);
    }, icon: Icon(Icons.chat)),AddFriendButton(this.email)],),);
  }
}

class messageTile extends StatelessWidget {
  String date;
  String sendby;
  String message_sent;
  bool sender_or_recevier;
  messageTile(this.date,this.sendby,this.message_sent,this.sender_or_recevier);
  @override
  Widget build(BuildContext context) {
    if(this.sender_or_recevier) {
      return ChatBubble(elevation: 20,margin: EdgeInsets.all(20),backGroundColor: Colors.grey,clipper: ChatBubbleClipper1(type: BubbleType.sendBubble),child: Container(padding: EdgeInsets.all(10),color: Colors.grey, alignment:Alignment.center, child: Row(children: [Column(children: [Text(this.date,style: TextStyle(color: Colors.black),),Text(this.sendby,style: TextStyle(color: Colors.black)),Text(this.message_sent,style: TextStyle(color: Colors.black)) ],),],)) ,);

    }
    else {
      return ChatBubble(elevation: 20,margin: EdgeInsets.all(20),backGroundColor: Colors.lightGreen,clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),child: Container(padding: EdgeInsets.all(10),color: Colors.lightGreen, alignment:Alignment.center, child: Row(children: [Column(children: [Text(this.date,style: TextStyle(color: Colors.black),),Text(this.sendby,style: TextStyle(color: Colors.black)),Text(this.message_sent,style: TextStyle(color: Colors.black)) ],),],)) ,);

    }
      // return Container(padding: EdgeInsets.all(10),color: Colors.lightGreen, alignment:Alignment.center, child: Row(children: [Column(children: [Text(this.date,style: TextStyle(color: Colors.black),),Text(this.sendby,style: TextStyle(color: Colors.black)),Text(this.message_sent,style: TextStyle(color: Colors.black)) ],),],));
  }
}

void createtile(searchTile tile, String emaill) async {
  DocumentSnapshot ds1 = await FirebaseFirestore.instance.collection("Users").doc(emaill).collection("kimlik").doc("email").get();
  DocumentSnapshot ds2 = await FirebaseFirestore.instance.collection("Users").doc(emaill).collection("kimlik").doc("isim").get();
  DocumentSnapshot ds3 = await FirebaseFirestore.instance.collection("Users").doc(emaill).collection("kimlik").doc("soyisim").get();


  String name2 = ds2.get("isim");
  String surname2 = ds3.get("soyisim");
  String email2 = ds1.get("email");

  // UserNew u = liste2.last;
  tile = new searchTile(email2,name2,surname2);
 // w1 = tile;

}