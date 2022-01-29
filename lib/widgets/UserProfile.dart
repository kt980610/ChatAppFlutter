import 'package:flutter/material.dart';
import 'package:housingapp/constants/colors.dart';
import 'package:housingapp/pages/navpages/bar_item_page.dart';
import 'package:housingapp/pages/navpages/home_page.dart';
import 'package:housingapp/pages/navpages/my_page.dart';
import 'package:housingapp/pages/navpages/search_page.dart';
class UserProfile extends StatelessWidget {
  String imagepath;
  String nameSurname;
  int age;
  bool isStudent;
  String uni;
  String interests;
  int housemates;
  UserProfile(this.imagepath,this.nameSurname,this.age,this.isStudent,this.uni,this.interests,this.housemates);
  @override
  Widget build(BuildContext context) {
    return Container(decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
    image: DecorationImage(
    image: AssetImage(this.imagepath,),
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
    buildUserInfo(this.nameSurname,this.imagepath,this.age,this.isStudent,this.uni,this.interests,this.housemates),
    Padding(
    padding: EdgeInsets.only(bottom: 16, right: 8),
    child: AddButton(),
    )
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
  buildUserInfo(this.nameSurname,this.imagePath,this.age,this.isStudent,this.uni,this.interests,this.housemates);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextButton(onPressed: () { 
            Navigator.push(context, MaterialPageRoute(builder: (context) => Profile(this.nameSurname, this.imagePath, this.age,this.isStudent,this.uni,this.interests,this.housemates),));
          } ,child:Text(
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
class MyProfile extends StatelessWidget {

  String nameSurname;
  String imagePath;
  int age;
  bool isStudent;
  String uni;
  String interests;
  int housemates;
  MyProfile(this.nameSurname,this.imagePath,this.age,this.isStudent,this.uni,this.interests,this.housemates);
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height*0.75;

    return Scaffold(
      appBar: AppBar(title: Text("PROFİLİM"),backgroundColor: Colors.green,),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(

                child: Stack(
                  children: <Widget>[
                    OpaqueImage(
                      this.imagePath,
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [

                            MyInfo(this.nameSurname,this.imagePath,this.age,this.isStudent,this.uni),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
          Positioned(
            top: screenHeight*0.7,
            left: 16,
            right: 16,
            child: Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ProfileInfoBigCard("ilgi alanları: ", this.interests, Icon(Icons.addchart)),
                  ProfileInfoBigCard("mevcut ev arkadaşı: ", this.housemates.toString(), Icon(Icons.contacts)),


                ],
              ),
            ),
          ),

        ],
      ),
    );
  }

}
class Profile extends StatelessWidget {
  String nameSurname;
  String imagePath;
  int age;
  bool isStudent;
  String uni;
  String interests;
  int housemates;
  Profile(this.nameSurname,this.imagePath,this.age,this.isStudent,this.uni,this.interests,this.housemates);

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height*0.8;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.green,),
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(

                child: Stack(
                  children: <Widget>[
                    OpaqueImage(
                      this.imagePath,
                    ),
                    SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [

                            MyInfo(this.nameSurname,this.imagePath,this.age,this.isStudent,this.uni),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
          Positioned(
            top: screenHeight*0.7,
            left: 16,
            right: 16,
            child: Container(
              height: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  ProfileInfoBigCard("ilgi alanları: ", this.interests, Icon(Icons.addchart)),
                  ProfileInfoBigCard("mevcut ev arkadaşı: ", this.housemates.toString(), Icon(Icons.contacts)),

                ],
              ),
            ),
          ),

        ],
      ),
    floatingActionButton: FloatingActionButton(backgroundColor: Colors.green, child: Icon(Icons.chat),onPressed: () {},),
    );
  }

}
class OpaqueImage extends StatelessWidget {

  String imageUrl;

  OpaqueImage(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Image.asset(
          this.imageUrl,
          width: double.maxFinite,
          height: 330,
          fit: BoxFit.fill,
        ),
        Container(
          color: Colors.white.withOpacity(0.85),
        ),
      ],
    );
  }
}
class RoundedImage extends StatelessWidget {
  final String imagePath;
  final Size size;

  const RoundedImage(this.imagePath,
    this.size);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        imagePath,
        width: size.width,
        height: size.width,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
class MyInfo extends StatelessWidget {
  String nameSurname;
  String imagePath;
  int age;
  bool isStudent;
  String uni;
  String ogrenci="";
  MyInfo(this.nameSurname,this.imagePath,this.age,this.isStudent,this.uni);
  @override
  Widget build(BuildContext context) {
    if(this.isStudent) {
        this.ogrenci="öğrenci";
    }
    else {
      this.ogrenci="";
      this.uni="";
    }
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RoundedImage(
              this.imagePath,
              Size.fromWidth(120.0),
            ),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                this.nameSurname + ", " + this.age.toString()+"\n"+this.ogrenci+"\n"+this.uni,
                style: TextStyle(color: Colors.green),
              ),

            ],
          ),


        ],
      ),
    );
  }
}
class ProfileInfoBigCard extends StatelessWidget {
  String firstText, secondText;
  Widget icon;

  ProfileInfoBigCard(this.firstText, this.secondText, this.icon);

  @override
  Widget build(BuildContext context) {
    return Card(

      margin: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(height: 250,width: 150,
        padding: const EdgeInsets.only(
          left: 16.0,
          top: 0,
          bottom: 0,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: icon,
            ),
            Text(firstText),
            Text(secondText),
          ],
        ),
      ),
    );
  }
}