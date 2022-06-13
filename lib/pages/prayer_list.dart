import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:prophetic_prayers/models/prayers.dart';
import 'package:prophetic_prayers/pages/prayer_detail_screen.dart';


class PrayerList extends StatefulWidget {
  const PrayerList({Key? key}) : super(key: key);

  @override
  State<PrayerList> createState() => _PrayerListState();
}

class _PrayerListState extends State<PrayerList> {
  final PageController _pageController = PageController(viewportFraction: 0.95);
  Color _iconColor = Color(0xFFE5E5EA);
  bool isTapped = false;

  double _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final int _height = 500;
  List<Scripture> scriptureList = [];

  final int _checkedStars = 4;

  @override
  void initState()  {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currPageValue = _pageController.page!;
      });
    });
    readJson().then((value) => scriptureList);
   // _currPageValue = getTodaysDay().toDouble();
  }

  @override
  void dispose() {
    _pageController.dispose();
  }
  Future<void> readJson() async {
    //read the json file
    final jsonData = await rootBundle.rootBundle.loadString('json/scriptures.json');

    final list = json.decode(jsonData) as List<dynamic>;
    scriptureList = list.map((e) => Scripture.fromJson(e)).toList();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Container(
          height: 500,
          width: size.width,
          child:GestureDetector(
            onTap: () {
              Get.to(PrayerDetailScreen(), arguments: [
                scriptureList[getTodaysDay()].title,
                scriptureList[getTodaysDay()].prayerPoint,
                scriptureList[getTodaysDay()].id,
                scriptureList[getTodaysDay()].verse]);
            },
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.only(left: 6, right: 6),
                    height: 100,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      image: DecorationImage(
                        image: AssetImage("images/diana-simum.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    child: Container(
                        width: 296,
                        margin: EdgeInsets.only(left: 20, bottom: 13),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          //mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text("Verse Of The Day", style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900), textAlign: TextAlign.start,),
                            ),
                            Expanded(child: Container(),),
                            Text(scriptureList[getTodaysDay()].title.toString(), style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.w900), textAlign: TextAlign.start,),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Icon(Icons.bolt, color: Colors.amberAccent, size: 18,),
                                SizedBox(width: 3,),
                                Text("streak 2", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                                SizedBox(width: 6,),
                                Icon(Icons.sunny, size: 18, color: Colors.amberAccent,),
                                SizedBox(width: 3,),
                                Text("weeks 32", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)
                              ],
                            ),
                            SizedBox(height: 14.3,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container()
                                    // Icon(Icons.add_alert_rounded, color: Colors.white, size: 18,),
                                    // Text("send me this daily", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    // Icon(Icons.favorite, color: Color(0xFFE5E5EA), size: 30,),
                                    IconButton(onPressed: (){
                                      setState((){
                                        isTapped = true;
                                      });
                                    }, icon:  Icon(Icons.favorite, color: isTapped==false?_iconColor:Colors.red, size: 30,))
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                    )
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),

      ],
    );
  }
  int getTodaysDay() {
    final date = DateTime.now();
    final diff = date.difference(new DateTime(date.year, 1, 1, 0, 0));
    final diffInDays = diff.inDays;
    print(diffInDays);
    return diffInDays;

  }

  Widget _buildPage(int index) {
    Matrix4 matrix = new Matrix4.identity();
    if (index == _currPageValue.floor()) {
      var _currScale = 1.0 - (_currPageValue - index) * (1 - _scaleFactor);
      var _currTrans = _height * (1 - _currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, _currScale, 1)
        ..setTranslationRaw(0, _currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var _currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var _currTrans = _height * (1 - _currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, _currScale, 1)
        ..setTranslationRaw(1, _currTrans, 2);
    } else if (index == _currPageValue.floor() - 1) {
      var _currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var _currTrans = _height * (1 - _currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, _currScale, 1)
        ..setTranslationRaw(1, _currTrans, 1);
    } else {
      var _currScale = 0.95;
      matrix = Matrix4.diagonal3Values(1, _currScale, 1)
        ..setTranslationRaw(0, _height * (1 - _currScale), 1);
    }
    return Transform(
      transform: matrix,
      child: Container()
    );
  }
}

