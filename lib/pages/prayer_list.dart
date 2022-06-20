import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import 'package:prophetic_prayers/models/prayers.dart';
import 'package:prophetic_prayers/pages/prayer_detail_screen.dart';
import 'package:prophetic_prayers/utils/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';


class PrayerList extends StatefulWidget {
  const PrayerList({Key? key}) : super(key: key);

  @override
  State<PrayerList> createState() => _PrayerListState();
}

class _PrayerListState extends State<PrayerList> {
  Color _iconColor = Color(0xFFE5E5EA);
  bool isTapped = false;

  List<Scripture> scriptureList = [];

  @override
  void initState() {
    super.initState();
    readJson();
    getStreak();
  }

  Future<void> readJson() async {
    //read the json file
    await DefaultAssetBundle.of(context)
        .loadString("json/scriptures.json")
        .then((jsonData) {
      setState(() {
        final list = json.decode(jsonData) as List<dynamic>;
        scriptureList = list.map((e) => Scripture.fromJson(e)).toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List images = [
      "images/child(26).jpg",
      "images/child(27).jpg",
      "images/child(28).jpg",
      "images/child(29).jpg",
      "images/child(30).jpg",
      "images/child(31).jpg",
      "images/child(32).jpg",
      "images/child(33).jpg",
      "images/child(34).jpg",
      "images/child(35).jpg",
      "images/child(36).jpg",
      "images/child(37).jpg",
      "images/child(38).jpg",
      "images/child(39).jpg",
      "images/child(40).jpg",
      "images/child(41).jpg",
      "images/child(42).jpg",
      "images/child(43).jpg",
      "images/child(44).jpg",
    ];
    var _selectedImage = images[Random().nextInt(images.length)];
    Size size = MediaQuery.of(context).size;
    return scriptureList.length > 0 ? Column(
      children: [
        Container(
          height: 500,
          width: size.width,
          child: GestureDetector(
            onTap: () {
              Get.to(()=> const PrayerDetailScreen(), arguments: [
                _selectedImage,
                scriptureList[getTodaysDay()-1].title,
                scriptureList[getTodaysDay()-1].prayerPoint,
                scriptureList[getTodaysDay()-1].id,
                scriptureList[getTodaysDay()-1].verse],
              );
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
                        image: AssetImage("images/" + _selectedImage),
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
                              child: Text("Verse Of The Day", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.w900),
                                textAlign: TextAlign.start,),
                            ),
                            Expanded(child: Container(),),
                            Text(scriptureList.length > 0
                                ? scriptureList[getTodaysDay()-1].title.toString()
                                : "", style: TextStyle(color: Colors.white,
                                fontSize: 28,
                                fontWeight: FontWeight.w900),
                              textAlign: TextAlign.start,),
                            SizedBox(height: 20,),
                            Row(
                              children: [
                                Icon(Icons.bolt, color: Colors.amberAccent,
                                  size: 18,),
                                SizedBox(width: 3,),
                                FutureBuilder(
                                  future: getStreak(),
                                  builder: (context, snapshot) {
                                    if(snapshot.hasData) {
                                    return Text(scriptureList.length > 0 ? "streak ${snapshot.data}" : "",
                                      style: TextStyle(color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),);
                                  } else {
                                      return Text("");
                                    }
    }
                                ),
                                SizedBox(width: 6,),
                                Icon(Icons.sunny, size: 18,
                                  color: Colors.amberAccent,),
                                SizedBox(width: 3,),
                                Text(scriptureList.length > 0 ? "week ${weekNumber(DateTime.now())}" : "",
                                  style: TextStyle(color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),)
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
                                    IconButton(onPressed: () {
                                      setState(() {
                                        isTapped = !isTapped;
                                      });
                                    },
                                        icon: Icon(Icons.favorite,
                                          color: isTapped == false
                                              ? _iconColor
                                              : Colors.red, size: 30,))
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
    ) : Container();
  }

  int getTodaysDay() {
    final date = DateTime.now();
    final diff = date.difference(new DateTime(date.year, 1, 1, 0, 0));
    final diffInDays = diff.inDays;
    print(diffInDays);
    return diffInDays;
  }
  int numOfWeeks(int year) {
    DateTime dec28 = DateTime(year, 12, 28);
    int dayOfDec28 = int.parse(DateFormat("D").format(dec28));
    return ((dayOfDec28 - dec28.weekday + 10) / 7).floor();
  }
  /// Calculates week number from a date as per https://en.wikipedia.org/wiki/ISO_week_date#Calculation
  int weekNumber(DateTime date) {
    int dayOfYear = int.parse(DateFormat("D").format(date));
    int woy =  ((dayOfYear - date.weekday + 10) / 7).floor();
    if (woy < 1) {
      woy = numOfWeeks(date.year - 1);
    } else if (woy > numOfWeeks(date.year)) {
      woy = 1;
    }
    print(woy);
    return woy;
  }
}