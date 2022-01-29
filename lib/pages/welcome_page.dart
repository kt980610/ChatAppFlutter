import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housingapp/constants/colors.dart';
import 'package:housingapp/widgets/app_lage_text.dart';
import 'package:housingapp/widgets/app_text.dart';
import 'package:housingapp/widgets/responsive_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  List title = [
    "House",
    "Mate",
    "House&Mate"
  ];

  List subTitle = [
    "Location & Price",
    "Trust & Eligible ",
    "What you need..."
  ];

  List text = [
    "Find an appropriate, purchasable, and comfortable house where you want.",
    "Mates are important. You should trust and have fun with them.",
    "You will find a HouseMate as your wish here!"
  ];

  List images = [
    "welcome-one.png",
    "welcome-two.png",
    "welcome-three.png",
  ];

  String imgDir = "img/";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (_,index){
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    imgDir+images[index]
                  ),
                  fit: BoxFit.cover
                )
              ),
              child: Container(
                margin: EdgeInsets.only(top: 100,left: 20,right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(text: title[index]),
                        AppText(text: subTitle[index],size: 30,),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: 250,
                          child: AppText(
                            text: text[index],
                            color: AppColors.textColor2,),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        ResponsiveButton(width: 120,)
                      ],
                    ),
                    Column(
                      children: List.generate(3, (indexDots){
                        return Container(
                          margin: EdgeInsets.only(bottom: 3),
                          width: 8,
                          height: index==indexDots ? 25 : 8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: index==indexDots ? AppColors.mainColor: AppColors.mainColor.withOpacity(0.3)
                          ),
                        );
                      }),
                    )
                  ],
                ),
              ),
            );
      }),
    );
  }
}
