import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housingapp/constants/currentUser.dart';
import 'package:housingapp/services/User.dart';
import 'package:housingapp/services/database.dart';
import 'package:housingapp/widgets/UserProfile.dart';
import 'package:housingapp/pages/navpages/chatRoom.dart';
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
List<UserNew> userlist = [];
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
 // List<searchTile> liste = [];
  @override
  Widget build(BuildContext context) {

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

                   // print(liste.last.email+ " EMAİL");
                    List<UserNew> liste = [];
                    setState(() {

                     /* db.search_user_by_mail(email, liste);
                      UserNew u = liste.last;
                      searchTile tile = new searchTile(u.email, u.name, u.surname);
                      w = tile;*/

                      FirebaseFirestore.instance.collection("Users2").doc(email).snapshots().listen((event) {
                        Map<String, dynamic> data = event.data()!;
                        searchTile tile = new searchTile(data['email'],data['isim'],data['soyisim']);
                      w = tile;
                      print(data['email']);

                      });
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
  searchTile(this.email,this.name,this.surname);
  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(10),color: Colors.lightGreen, alignment:Alignment.center, child: Row(children: [Column(crossAxisAlignment:CrossAxisAlignment.start,children: [Text(this.email,style: TextStyle(color: Colors.black),),Text(this.name,style: TextStyle(color: Colors.black)),Text(this.surname,style: TextStyle(color: Colors.black)), ],),Spacer(),IconButton(onPressed: () {
      List<messageTile> liste = [];
      ChatRoomInfo info= new ChatRoomInfo();//db.getMessages(this.email);
      FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc("messageCount").snapshots().listen((event) { Map<String, dynamic>? data = event.data()!;
      //info.setCount(data["count"]);
      info.setCount(data["count"]);
      for (var i=info.message_count;i>0;i--) {
        message m = new message();
        FirebaseFirestore.instance.collection(Constants.myName).doc("chatroom").collection(email).doc(i.toString()).snapshots().listen((event) { Map<String, dynamic>? data = event.data()!;
        m.setMessage(data["message"]);
        m.setSendBy(data["sendby"]);
        m.setDate(data["date"]);
        messageTile tile = new messageTile(m.date, m.sendby, m.mesaj);
        liste.add(tile);
        });

      }
      Navigator.push(context, MaterialPageRoute(builder: (context) => chatRoom(email, liste)),);







      });

    }, icon: Icon(Icons.chat)),AddFriendButton(this.email)],),);
  }
}
 void addUser(UserNew u) {
  userlist.clear();
  userlist.add(u);
}
class messageTile extends StatelessWidget {
  String date;
  String sendby;
  String message_sent;
  messageTile(this.date,this.sendby,this.message_sent);
  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(10),color: Colors.lightGreen, alignment:Alignment.center, child: Row(children: [Column(children: [Text(this.date,style: TextStyle(color: Colors.black),),Text(this.sendby,style: TextStyle(color: Colors.black)),Text(this.message_sent,style: TextStyle(color: Colors.black)), ],),Spacer(),],));
  }
}

