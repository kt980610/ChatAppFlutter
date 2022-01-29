import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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

class _userSearchState extends State<userSearch> {
  database db = new database();
  String email = "";
  List<searchTile> liste = [];
  Widget w = Container();
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

                    db.search_user_by_mail(email);
                    setState(() {

                      searchTile tile = new searchTile(
                          userlist.last.email,userlist.last.name,userlist.last.surname);
                      liste.clear();
                      liste.add(tile);
                      w=liste.last;
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
      Navigator.push(context, MaterialPageRoute(builder: (context) => chatRoom(this.email)),);
    }, icon: Icon(Icons.chat))],));
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

