import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:prophetic_prayers/models/prayers.dart';
import 'package:prophetic_prayers/pages/prayer_detail_screen.dart';
import 'package:prophetic_prayers/utils/dimensions.dart';

import '../models/streak.dart';
import '../utils/shared_preferences.dart';


class PrayerList extends StatefulWidget {
  const PrayerList({Key? key}) : super(key: key);

  @override
  State<PrayerList> createState() => _PrayerListState();
}

class _PrayerListState extends State<PrayerList> {
  final Color _iconColor = const Color(0xFFE5E5EA);
  //bool isTapped = false;

  List<Scripture> scriptureList = [];

  @override
  void initState() {
    super.initState();
    readJson();
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
    //String _streakController = widget.streak.streak.toString();
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
    var selectedImage = images[Random().nextInt(images.length)];
    Size size = MediaQuery.of(context).size;
    return scriptureList.isNotEmpty ? Column(
      children: [
        Container(
          height: Dimensions.prayerListColumnContainerHeight500,
          width: size.width,
          child: GestureDetector(
            onTap: () {
              Get.to(()=> const PrayerDetailScreen(), arguments: [
                selectedImage,
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
                    margin: EdgeInsets.only(left: Dimensions.prayerListStackPositionedContainerWidth6, right: Dimensions.prayerListStackPositionedContainerWidth6),
                    height: Dimensions.prayerListStackPositionedContainerHeight100,
                    width: Dimensions.prayerListStackPositionedContainerWidth100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.prayerListStackPositionedContainerHeightRadius30),
                      image: DecorationImage(
                        image: AssetImage(selectedImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                    child: Container(
                        width: Dimensions.prayerListStackPositionedContainerHeight296,
                        margin: EdgeInsets.only(left: Dimensions.prayerListStackPositionedContainerWidth20, bottom: Dimensions.prayerListStackPositionedContainerHeight13),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: Dimensions.prayerListStackPositionedContainerHeight10),
                              child: Text("Verse Of The Day", style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Dimensions.prayerListStackPositionedContainerTextWidth28,
                                  fontWeight: FontWeight.w900),
                                textAlign: TextAlign.start,),
                            ),
                            Expanded(child: Container(),),
                            Text(scriptureList.isNotEmpty
                                ? scriptureList[getTodaysDay()-1].title.toString()
                                : "", style: TextStyle(color: Colors.white,
                                fontSize: Dimensions.prayerListStackPositionedContainerTextWidth28,
                                fontWeight: FontWeight.w900),
                              textAlign: TextAlign.start,),
                            SizedBox(height: Dimensions.prayerListStackPositionedContainerHeight20,),
                            scriptureList.isNotEmpty ? Row(
                              children: [
                                // Icon(Icons.bolt, color: Colors.amberAccent,
                                //   size: Dimensions.prayerListStackPositionedContainerIconWidth18,),
                               // SizedBox(width: Dimensions.prayerListStackPositionedContainerWidth3,),
                                // FutureBuilder(
                                //     future: DatabaseHelper.instance.checkStreak(),
                                //     builder: (context, snapshot) {
                                //       if(!snapshot.hasData) {
                                //         return Text("streak 0", style: TextStyle(color: Colors.white,
                                //             fontSize: Dimensions.prayerListStackPositionedContainerIconWidth18,
                                //             fontWeight: FontWeight.bold));
                                //       }
                                //       return Text(snapshot.data.toString(),
                                //         style: TextStyle(color: Colors.white,
                                //             fontSize: Dimensions.prayerListStackPositionedContainerIconWidth18,
                                //             fontWeight: FontWeight.bold),
                                //       );
                                //     }
                                // ),
                               // SizedBox(width: Dimensions.prayerListStackPositionedContainerWidth6,),
                                Icon(Icons.sunny, size: Dimensions.prayerListStackPositionedContainerIconWidth18,
                                  color: Colors.amberAccent,),
                                SizedBox(width: Dimensions.prayerListStackPositionedContainerWidth3,),
                                Text(scriptureList.isNotEmpty ? "week ${weekNumber(DateTime.now())}" : "",
                                  style: TextStyle(color: Colors.white,
                                      fontSize: Dimensions.prayerListStackPositionedContainerIconWidth18,
                                      fontWeight: FontWeight.bold),)
                              ],
                            ): Container(),
                            SizedBox(height: Dimensions.prayerListStackPositionedContainerHeight14,),
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
                                // Row(
                                //   children: [
                                //     // Icon(Icons.favorite, color: Color(0xFFE5E5EA), size: 30,),
                                //     IconButton(onPressed: () {
                                //       setState(() {
                                //         isTapped = !isTapped;
                                //       });
                                //     },
                                //         icon: Icon(Icons.favorite,
                                //           color: isTapped == false
                                //               ? _iconColor
                                //               : Colors.red, size: Dimensions.prayerListStackPositionedContainerIconWidth30,))
                                //   ],
                                // )
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
          height: Dimensions.prayerListStackPositionedContainerHeight10,
        ),

      ],
    ) : Container();
  }

  int getTodaysDay() {
    final date = DateTime.now();
    final diff = date.difference(DateTime(date.year, 1, 1, 0, 0));
    final diffInDays = diff.inDays;
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
    return woy;
  }
}