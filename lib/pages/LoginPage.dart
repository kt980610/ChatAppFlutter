//import 'dart:html';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:housingapp/constants/colors.dart';
import 'package:housingapp/pages/navpages/main_page.dart';
import 'package:flutter/material.dart';
import 'package:housingapp/pages/navpages/SignUp.dart';
import 'package:housingapp/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'firebase_options.dart';
String ID = "";
auth a = new auth();
class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loginBody(),
    );
  }
}
class loginBody extends StatelessWidget {
  String email = "";
  String password = "";
  bool check = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loginBackground(
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "LOGIN",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Container(child: roundedImage('img/welcome-one.png',100),),
            SizedBox(height: size.height * 0.03),
            TextFieldContainer(
              TextField( onChanged: (value) {
                email=value;
              },
                onSubmitted: (value) {
                  if(value.contains("@")) {
                    email = value;
                  }
                },
                cursorColor: AppColors.mainColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: AppColors.mainColor,
                  ),
                  hintText: "your email",
                  border: InputBorder.none,
                ),
              ),
            ),
            TextFieldContainer(
              TextField(
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                onSubmitted: (value) {
                  password = value;
                },
                cursorColor: AppColors.mainColor,
                decoration: InputDecoration(
                  hintText: "Password",
                  icon: Icon(
                    Icons.lock,
                    color: AppColors.mainColor,
                  ),
                  suffixIcon: Icon(
                    Icons.visibility,
                    color: AppColors.mainColor,
                  ),
                  border: InputBorder.none,
                ),
              ),
            ),


            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: ElevatedButton(child: Text("Sign In"), onPressed: () {
                    a.signIn(email, password, context);

                },),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
                true
            ),
            TextButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => forgotPass()),); }, child: Text("Şifremi unuttum"), ),
          ],
        ),
      ),
    );
  }
}
class forgotPass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: forgotPassBody(),
    );
  }
}
class forgotPassBody extends StatelessWidget {
  String email = "";
  String password = "";
  bool check = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loginBackground(
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            SizedBox(height: size.height * 0.03),
            Container(child: roundedImage('img/welcome-one.png',100),),
            SizedBox(height: size.height * 0.03),
            TextFieldContainer(
              TextField( onChanged: (value) {
                email=value;
              },
                onSubmitted: (value) {
                  if(value.contains("@")) {
                    email = value;
                  }
                },
                cursorColor: AppColors.mainColor,
                decoration: InputDecoration(
                  icon: Icon(
                    Icons.person,
                    color: AppColors.mainColor,
                  ),
                  hintText: "your email",
                  border: InputBorder.none,
                ),
              ),
            ),



            Container(
              margin: EdgeInsets.symmetric(vertical: 10),
              width: size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(29),
                child: ElevatedButton(child: Text("Sıfırla"), onPressed: () {
                  a.resetPass(email);

                },),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            /*AlreadyHaveAnAccountCheck(
                true
            ),*/
            //TextButton(onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => forgotPass()),); }, child: Text("Şifremi unuttum"), ),
          ],
        ),
      ),
    );
  }
}
class loginBackground extends StatelessWidget {
  final Widget child;
  const loginBackground(
      this.child,
      ) ;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              "img/main_top.png",
              width: size.width * 0.35,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset(
              "img/login_bottom.png" ,
              width: size.width * 0.4,
            ),
          ),
          this.child,
        ],
      ),
    );
  }
}



class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer(

      this.child,
      ) ;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(29),
      ),
      child: this.child,
    );
  }
}
class roundedImage extends StatelessWidget {
  final String imagePath;
  final double size;

  const roundedImage(
      this.imagePath,
      this.size,
      );

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Image.asset(
        imagePath,
        width: this.size,
        height: this.size,
        fit: BoxFit.fitWidth,
      ),
    );
  }
}
class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  const AlreadyHaveAnAccountCheck(
      this.login,

      ) ;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "Don’t have an Account ? " : "Already have an Account ? ",
          style: TextStyle(color: Colors.blue),
        ),
        GestureDetector(
          onTap: () {
            if(this.login==false) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            }
            else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return signUpScreen();
                  },
                ),
              );
            }
          },
          child: Text(
            login ? "Sign Up" : "Sign In",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

      ],
    );
  }
}

/*void signIn(String email, String password,BuildContext context) async {
  try {

    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
    );
    Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()),);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      print('No user found for that email.');
    } else if (e.code == 'wrong-password') {
      print('Wrong password provided for that user.');
    }
  }
}*/