import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:housingapp/constants/currentUser.dart';
import 'package:housingapp/pages/navpages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:housingapp/pages/LoginPage.dart';
import 'dart:convert';
class auth {

  int count = 0;
  auth();
  void signIn(String email, String password,BuildContext context) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      Constants.myName=email;
      Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()),);
    } on FirebaseAuthException catch (e) {
     // Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()),);
      /* FirebaseFirestore.instance.collection("userCount").doc("usercount").snapshots().listen((event) { Map<String, dynamic> data = event.data()!;

      // You can then retrieve the value from the Map like this:
      this.setCount(data['count']);
      });

      print("USERCOUNT "+ this.count.toString()); */


      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
  void setCount(int count1) {
    this.count=count1;
  }
  void createUser(String email,String password, String name1, String surname1, BuildContext context) async {

   // await Firebase.initializeApp();

   try {
     DocumentSnapshot ds = await FirebaseFirestore.instance.collection("userCount").doc("usercount").get();
     int count = ds.get("count")+1;
     FirebaseFirestore.instance.collection("userCount").doc("usercount").set({"count":count});
   UserCredential newUser = await FirebaseAuth.instance
         .createUserWithEmailAndPassword(
         email: email, password: password);



     var arr = [-1,-1,-1,-1,-1,-1,-1,-1,-1,-1];


      FirebaseFirestore.instance.collection("UsersV2").doc(count.toString()).set({})
     FirebaseFirestore.instance.collection("UsersV2").doc(count.toString()).set({"isim":name1});

     FirebaseFirestore.instance.collection("UsersV2").doc(count.toString()).set({"soyisim":surname1});
     
     FirebaseFirestore.instance.collection("UsersV2").doc(count.toString()).set({"email":email});
     FirebaseFirestore.instance.collection("UsersV2").doc(count.toString()).set({"kriterler":arr});
    FirebaseFirestore.instance.collection("Users").doc(email).collection("kimlik").doc("isim").set({"isim": name1});
     FirebaseFirestore.instance.collection("Users").doc(email).collection("kimlik").doc("soyisim").set(
         {"soyisim": surname1});
     FirebaseFirestore.instance.collection("Users").doc(email).collection("kimlik").doc("email").set(
         {"email": email});
     FirebaseFirestore.instance.collection("Users").doc(email).collection("index").doc("index").set(
         {"index": count});
     FirebaseFirestore.instance.collection("Users").doc(email).collection("kriterler").doc("alkol").set(
         {"alkol": "-1"});
     FirebaseFirestore.instance.collection("Users").doc(email).collection("kriterler").doc("düzen").set(
         {"düzen": "-1"});
     FirebaseFirestore.instance.collection("Users").doc(email).collection("kriterler").doc("evcil hayvan").set(
         {"evcil hayvan": "-1"});
     FirebaseFirestore.instance.collection("Users").doc(email).collection("kriterler").doc("eşya kullanımı").set(
         {"eşya kullanımı": "-1"});
     FirebaseFirestore.instance.collection("Users").doc(email).collection("kriterler").doc("gürültü").set(
         {"gürültü": "-1"});
     FirebaseFirestore.instance.collection("Users").doc(email).collection("kriterler").doc("misafir").set(
         {"misafir": "-1"});
     FirebaseFirestore.instance.collection("Users").doc(email).collection("kriterler").doc("paylaşımcılık").set(
         {"paylaşımcılık": "-1"});
     FirebaseFirestore.instance.collection("Users").doc(email).collection("kriterler").doc("samimiyet").set(
         {"samimiyet": "-1"});
     FirebaseFirestore.instance.collection("Users").doc(email).collection("kriterler").doc("sigara").set(
         {"sigara": "-1"});
     FirebaseFirestore.instance.collection("Users").doc(email).collection("kriterler").doc("temizlik").set(
         {"temizlik": "-1"});
     Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()),);
   }
   catch(e) {
     print(e);
   }
  }
  void sign_out(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()),);
    }
    catch (e) {
      print(e);
    }
  }
  void resetPass(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

}
class RoundedPreferenceField extends StatelessWidget {
  final String hintText;
  final String kriter;
  final String username;

  const RoundedPreferenceField(
      this.hintText,
      this.kriter,
      this.username,
      );

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      TextField( onChanged: (value) {
        double a = double.parse(value);
        if (a <= 10 && a >= 0) {
          FirebaseFirestore.instance.collection("Users").doc(username).collection("kriterler").doc(this.kriter).set(
              {this.kriter: value});

        }

      },
        cursorColor: Colors.lightGreen,
        decoration: InputDecoration(

          hintText: this.hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}