import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housingapp/pages/navpages/bar_item_page.dart';
import 'package:housingapp/pages/navpages/home_page.dart';
import 'package:housingapp/pages/navpages/my_page.dart';
import 'package:housingapp/pages/navpages/search_page.dart';
import 'package:housingapp/constants/currentUser.dart';
class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}
int currentIndex = 0;


class _MainPageState extends State<MainPage> {
  void onTap(int index,BuildContext context){

    setState(() {
      currentIndex = index;
    });


  }
  List pages = [
    HomePage(),
    userSearch(),
    SearchPage(),
    MyPage(),
  ];

 // int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        backgroundColor: Colors.white,
        onTap: (index) {
        setState(() {
        currentIndex = index;
        });

        },
        currentIndex: currentIndex,
        selectedItemColor: Colors.black54,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: [
        BottomNavigationBarItem(label: "Home",icon: Icon(Icons.apps)),
        BottomNavigationBarItem(label: "Bar",icon: Icon(Icons.bar_chart_sharp)),
        BottomNavigationBarItem(label: "Search",icon: Icon(Icons.search)),
        BottomNavigationBarItem(label: "My",icon: Icon(Icons.person),),
      ],),
    );
  }
}
