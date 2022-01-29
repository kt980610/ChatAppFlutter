import 'package:flutter/material.dart';
import 'package:housingapp/pages/LoginPage.dart';
import 'package:housingapp/constants/colors.dart';
import 'package:housingapp/services/auth.dart';
String ID = "";
String name = "";
String surname = "";
String confirm_password = "";
class signUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: signUpBody(),
    );
  }
}
class signUpBody extends StatelessWidget {
  String email = "";
  String password = "";
  bool check = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return signUpBackground(
      SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Sign Up",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: size.height * 0.03),
            Container(child: roundedImage('img/welcome-one.png',100),),
            SizedBox(height: size.height * 0.03),
            TextFieldContainer( TextField(decoration: InputDecoration(border: InputBorder.none,icon: Icon(Icons.person, color: AppColors.mainColor,), hintText: "isim") ,onSubmitted: (value) {
              name=value;
            },onChanged: (value) { name=value;},),),
            TextFieldContainer( TextField(decoration: InputDecoration(border: InputBorder.none,icon: Icon(Icons.person, color: AppColors.mainColor,), hintText: "soyisim"), onSubmitted: (value) {
              surname=value;
            },onChanged: (value) { surname=value;},),),

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
                  hintText: "Enter your email",
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
                  hintText: "choose a password",
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
        TextFieldContainer(
          TextField(
            obscureText: true,
            onChanged: (value) {
              confirm_password = value;
            },
            onSubmitted: (value) {
              confirm_password= value;
            },
            cursorColor: AppColors.mainColor,
            decoration: InputDecoration(
              hintText: "confirm your password",
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
                child: ElevatedButton(child: Text("Sign Up"),onPressed: () {
                   if(password == confirm_password) {
                     auth().createUser(email, password, name, surname, context);
                   }

                },),
              ),
            ),
            SizedBox(height: size.height * 0.03),
            AlreadyHaveAnAccountCheck(
                false
            ),
          ],
        ),
      ),
    );
  }
}
class signUpBackground extends StatelessWidget {
  final Widget child;
  const signUpBackground(
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

