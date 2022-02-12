import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:housingapp/constants/colors.dart';
import 'package:housingapp/pages/navpages/bar_item_page.dart';
import 'package:housingapp/pages/navpages/home_page.dart';
import 'package:housingapp/pages/navpages/main_page.dart';
import 'package:housingapp/pages/navpages/my_page.dart';
import 'package:housingapp/pages/navpages/search_page.dart';
import 'package:housingapp/services/database.dart';
import 'package:housingapp/pages/navpages/chatRoom.dart';
import 'package:housingapp/pages/navpages/bar_item_page.dart';
import 'package:housingapp/pages/navpages/chatRoom.dart';
import 'package:housingapp/constants/currentUser.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:housingapp/pages/navpages/main_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housingapp/services/database.dart';



class updatedProfile extends StatefulWidget {
  String imgpath;
  String nameSurname;
  String email;
  updatedProfile(this.nameSurname,this.email,this.imgpath);
  @override
  _updatedProfileState createState() => _updatedProfileState(this.nameSurname,this.email,this.imgpath);
}

class _updatedProfileState extends State<updatedProfile> {
  String nameSurname;
  String email;
  String imgpath;
  _updatedProfileState(this.nameSurname,this.email,this.imgpath);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color:  Colors.green,),
        backgroundColor: Colors.transparent,
        elevation: 0,

      ),
      body:  ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: imgpath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          Column(
            children: [
              Text(
                this.nameSurname,//Constants.myName,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 4),
              Text(
                this.email,
                style: TextStyle(color: Colors.grey),
              )
            ],
          ),
          //buildName(),
          const SizedBox(height: 24),
          Center(child: Container(), /* IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},*/
          ), /*buildUpgradeButton()*/ //),
          const SizedBox(height: 24),
          // NumbersWidget(),
          const SizedBox(height: 48),
          buildAbout(""),
        ],
      ),

      floatingActionButton: addorchat(true, this.email),
    );
  }
}

class updatedMyProfile extends StatefulWidget {
  String nameSurname;
  String email;

  updatedMyProfile(this.nameSurname,this.email);

  @override
  _updatedMyProfileState createState() => _updatedMyProfileState(this.nameSurname,this.email);
}

class _updatedMyProfileState extends State<updatedMyProfile> {
  String nameSurname;
  String email;
  String about = "";
  String about2 = "";
  String htext = "";
  String imagepath = Constants.imgpath;
  Widget w2 = Container();
  Widget w3 = Container();
  _updatedMyProfileState(this.nameSurname,this.email);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color:  Colors.green,),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(color: Colors.green,
            icon: Icon(Icons.notifications,color: Colors.green,),
            onPressed: () {},
          ),
        ],
      ),
      body:  ListView(
        physics: BouncingScrollPhysics(),
    children: [
    MyProfileWidget(
    imagePath: this.imagepath,//"https://firebasestorage.googleapis.com/v0/b/housemates-569de.appspot.com/o/kerem.tuna%40windowslive.com?alt=media&token=0c922a0d-5e5a-46e4-9473-db4e94086db0",
    onClicked: () async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: false);
      if (result==null) return;
      final path = result.files.single.path!;
      setState(() {
       File file = File(path);
       FirebaseStorage.instance.ref(Constants.myName).delete();
       FirebaseStorage.instance.ref(Constants.myName).putFile(file);

      });
      var url = await FirebaseStorage.instance.ref(Constants.myName).getDownloadURL();
      this.imagepath = url.toString();
    },
    ),
    const SizedBox(height: 24),
        Column(
          children: [
            Text(
              this.nameSurname,//Constants.myName,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
            const SizedBox(height: 4),
            Text(
              Constants.myName,
              style: TextStyle(color: Colors.grey),
            )
          ],
        ),
   // buildName(user),
    const SizedBox(height: 24),
    Center(child: IconButton(
      icon: Icon(Icons.edit),
      onPressed: () {

        setState(() {
          this.about="";
            w2 = TextField(decoration: InputDecoration(hintText: "ekle: "),onChanged: (value) {
              this.about=value;
            },);
            Widget tb = TextButton(onPressed: () {setState(() {
              w3= Container();
              w2 = Container();
            });}, child: Text("Bitir"),);
            w3 = tb;

        });
      },
    ), /*buildUpgradeButton()*/ ),
    const SizedBox(height: 24),
   // NumbersWidget(),
    const SizedBox(height: 48),
    buildAbout(this.about),w2,w3,
    ],
    ),


    );
  }
}
class addorchat extends StatefulWidget {
  late bool b;
  late String email;
  addorchat(this.b,this.email);

  @override
  _addorchatState createState() => _addorchatState(this.b,this.email);
}

class _addorchatState extends State<addorchat> {
  bool b;
  String email;
  _addorchatState(this.b,this.email);
  @override
  Widget build(BuildContext context) {
    if(this.b) {
      return IconButton(onPressed: () { Constants.messageList.clear();
      Constants.db.getMessages(this.email);
      int messagecount=Constants.messageList.length;
      //print(liste2.length.toString()+" SİZE");
      Navigator.push(context, MaterialPageRoute(builder: (context) => chatRoom(email, messagecount)),);
    }, icon: Icon(Icons.chat));
    }
    else {
      return AddFriendButton(this.email);
    }
  }
}

class UserProfile extends StatelessWidget {
  String imagepath;
  String nameSurname;
  int age;
  bool isStudent;
  String uni;
  String interests;
  int housemates;
  String email2;
  bool isfriend;
  UserProfile(this.imagepath,this.nameSurname,this.age,this.isStudent,this.uni,this.interests,this.housemates,this.email2,this.isfriend);
  //Widget w = addorchat(this.isfriend,this.email2);
  @override
  Widget build(BuildContext context) {
   // print(this.isfriend);
    return Container(decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
    image: DecorationImage(
    image: NetworkImage(this.imagepath,),
    fit: BoxFit.cover,),),
    child: Container(
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
    BoxShadow(color: Colors.black12, spreadRadius: 0.5),
    ],
    gradient: LinearGradient(
    colors: [Colors.black12, Colors.black87],
    begin: Alignment.center,
    stops: [0.4, 1],
    end: Alignment.bottomCenter,
    ),
    ),
    child: Stack(
    children: [
    Positioned(
    right: 10,
    left: 10,
    bottom: 10,
    child: Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    buildUserInfo(this.nameSurname,this.imagepath,this.age,this.isStudent,this.uni,this.interests,this.housemates,this.email2),
    Padding(
    padding: EdgeInsets.only(bottom: 16, right: 8),
    child: addorchat(this.isfriend, this.email2),
    ),
    ],
    ),
    ),
    ],
    ),
    ),
    );
  }
}
class buildUserInfo extends StatelessWidget {
  String imagePath;
  String nameSurname;
  int age;
  bool isStudent;
  String uni;
  String interests;
  int housemates;
  String email2;
  buildUserInfo(this.nameSurname,this.imagePath,this.age,this.isStudent,this.uni,this.interests,this.housemates,this.email2);
  @override
  Widget build(BuildContext context) {
    return Padding(

      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(onPressed: () async {
            var url = await FirebaseStorage.instance.ref(this.email2).getDownloadURL();
            String imgpath = url.toString();

            Navigator.push(context, MaterialPageRoute(builder: (context) => updatedProfile(this.nameSurname,this.email2,imgpath)/*Profile(this.nameSurname, this.imagePath, this.age,this.isStudent,this.uni,this.interests,this.housemates,this.email2)*/,));
          },child:Text(
            this.nameSurname + ", " + this.age.toString(),
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          ),
          SizedBox(height: 8),

        ],
      ),
    );
  }

}
class AddButton extends StatefulWidget {

  @override
  State<AddButton> createState() => AddButtonState();

}
class AddButtonState extends State<AddButton> {
  Icon i = Icon(Icons.add,color: Colors.white,);
  void added() {
    setState(() {
      i = Icon(Icons.check,color: Colors.white,);
    });

  }
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: added, icon: i,);
  }


}
class AddFriendButton extends StatefulWidget {
  late String email;
  AddFriendButton(this.email);
  @override
  State<AddFriendButton> createState() => AddFriendButtonState(this.email);

}
class AddFriendButtonState extends State<AddFriendButton> {
  String email;
  AddFriendButtonState(this.email);
  Icon i = Icon(Icons.add,color: Colors.white,);
  void added() {
    setState(() {
      i = Icon(Icons.check,color: Colors.white,);
      Constants.db.create_chatroom(this.email);
    });

  }
  @override
  Widget build(BuildContext context) {
    return IconButton(onPressed: () { added();}, icon: i,);
  }


}
class rectImage extends StatelessWidget {
  final String imagePath;
  final double size;

  const rectImage(
      this.imagePath,
      this.size,
      );

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: Image.asset(
        imagePath,
        width: this.size,
        height: this.size,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}

class MyProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const MyProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);//AssetImage(imagePath) ;// NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
    color: Colors.white,
    all: 3,
    child: buildCircle(
      color: color,
      all: 8,
      child: Icon(
        Icons.edit,
        color: Colors.white,
        size: 20,
      ),
    ),
  );

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );
}
class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final color = Theme
        .of(context)
        .colorScheme
        .primary;

    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: Container(), //buildEditIcon(color),
          ),
        ],
      ),
    );
  }
  Widget buildImage() {
    final image = NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }
}
Widget buildAbout(String about) { return Container(
  padding: EdgeInsets.symmetric(horizontal: 48),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'About',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,),
      ),
      const SizedBox(height: 16),
      Text(
        about,
        style: TextStyle(fontSize: 16, height: 1.4),
      ),
    ],
  ),
);
}
