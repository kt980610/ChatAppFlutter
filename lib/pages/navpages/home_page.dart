import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:housingapp/constants/colors.dart';
import 'package:housingapp/widgets/app_lage_text.dart';
import 'package:housingapp/services/auth.dart';
import 'package:housingapp/pages/LoginPage.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin{

  @override
  Widget build(BuildContext context) {
    TabController _tabController = TabController(length: 3, vsync: this);
    return Scaffold(appBar: AppBar(title: Text("Housemates"),backgroundColor: Colors.green,actions: [IconButton(icon: Icon(Icons.exit_to_app),onPressed: () { a.sign_out(context); },)],),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(top: 70,left: 20),
            child: Row(
              children: [
                Icon(Icons.menu,size: 30,color: Colors.black54,),
                Expanded(child: Container()),
                Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.only(right: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.5)
                  ) ,
                ),
              ],
            ),
          ),
          SizedBox(height: 40,),
          // Discover Title
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: AppLargeText(text: "Discover"),
          ),
          SizedBox(height: 40,),
          Container(
            child: Align(
              //alignment: Alignment.centerLeft,
              child: TabBar(
                labelPadding: EdgeInsets.only(left: 20,right: 20),
                controller: _tabController,
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                // isScrollable: true,
                indicatorSize: TabBarIndicatorSize.label,
                indicator: CircleTabIndicator(color: AppColors.mainColor,radius: 4),
                tabs: [
                Tab(text: "Regions",),
                Tab(text: "Mates",),
                Tab(text: "News",),
              ],),
            ),
          ),
          Container(
            height: 300,
            width: double.maxFinite,
            child: TabBarView(
              controller: _tabController,
              children: [
                Text("Region 1"),
                Text("Mate 1"),
                Text("New 1"),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CircleTabIndicator extends Decoration{

  final Color color;
  double radius;

  CircleTabIndicator({
    required this.color,
    required this.radius
  });

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    // TODO: implement createBoxPainter
    return _CirclePainter(color:color,radius:radius);
  }

}

class _CirclePainter extends BoxPainter{
  final Color color;
  double radius;

  _CirclePainter({
    required this.color,
    required this.radius
  });
  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {

    Paint _paint = Paint();
    _paint.color=color;
    _paint.isAntiAlias= true;
    final Offset circleOffset = Offset(configuration.size!.width/2,configuration.size!.height-radius);
    canvas.drawCircle(offset+circleOffset, radius, _paint);
  }

}