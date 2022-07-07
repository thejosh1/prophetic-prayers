import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prophetic_prayers/controller/scripture_controller.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/prayer_detail_screen.dart';
import 'package:prophetic_prayers/pages/prayer_screen.dart';
import 'package:prophetic_prayers/utils/dimensions.dart';
import '../models/prayers.dart';

class PrayerListScreen extends StatefulWidget {
  const PrayerListScreen({Key? key}) : super(key: key);

  @override
  State<PrayerListScreen> createState() => _PrayerListScreenState();
}

class _PrayerListScreenState extends State<PrayerListScreen> {

  @override
  void iniState(){
    super.initState();
    readJson();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: SingleChildScrollView(
           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Container(
                 margin: EdgeInsets.only(left: Dimensions.prayerListScreenContainerWidth10, right: Dimensions.prayerListScreenContainerWidth16, top: Dimensions.prayerListScreenContainerHeight44),
                 child: Row(
                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                   children: [
                     IconButton(onPressed: (){Get.to(()=> const PrayerScreen());}, icon: Icon(Icons.arrow_back, size: Dimensions.prayerListScreenContainerWidth18, color: Color(0xFF000000),)),
                  //   IconButton(onPressed: (){}, icon: Icon(Icons.more_vert, size: 20, color: Color(0xFF000000),))
                   ],
                 ),
               ),
               Divider(
                 height: Dimensions.prayerListScreenContainerHeight2,
                 color: Color(0xFFEAECEF),
                 thickness: Dimensions.prayerListScreenContainerWidth2,
               ),
               SizedBox(height: Dimensions.prayerListScreenContainerheight22,),
               Container(
                   margin: EdgeInsets.only(left: Dimensions.prayerListScreenContainerWidth20),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Text("Prayers For the Year", style: TextStyle(fontSize: Dimensions.prayerListScreenContainerWidth16, fontWeight: FontWeight.bold, color: Color(0xFF1E2432)),),
                       SizedBox(height: Dimensions.prayerListScreenContainerHeight27,),
                       Container(
                         height: Dimensions.prayerListScreenContainerHeight532,
                         width: Dimensions.prayerListScreenContainerWidth335,
                         child: FutureBuilder(
                           future: readJson(),
                           builder: (context, snapshot) {
                             if(snapshot.hasError) {
                               return Center(child: Text("${snapshot.error}"));
                             } else if(snapshot.hasData){

                               var _scriptures = snapshot.data as List<Scripture>;

                               return buildScriptures(_scriptures);
                             } else {
                               return Center(child: Text("Loading"),);
                             }
                           }
                         )
                       )
                     ],
                   )
               )
             ],
           ),
         ),
    );

  }
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
  Widget buildScriptures(List<Scripture> scriptures) => ListView.builder(
      itemCount: scriptures.length ,
      itemBuilder: (_, index) {
        final scriptureList = scriptures[index];
        var _selectedImage = images[Random().nextInt(images.length)];
        return GestureDetector(
          onTap: (){
            Get.to(()=> const PrayerDetailScreen(), arguments: [
              _selectedImage,
              scriptureList.title,
              scriptureList.prayerPoint,
              scriptureList.id,
              scriptureList.verse]);
          },
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: Dimensions.prayerListScreenContainerHeight110,
                    width: Dimensions.prayerListScreenContainerWidth90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.pageScreenExpandedRadiusHeight10),
                      image: DecorationImage(
                          image: AssetImage(images[Random().nextInt(images.length)]),
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                  SizedBox(width: Dimensions.prayerListScreenContainerWidth15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: Dimensions.prayerListScreenContainerWidth150,
                          child: Text(scriptureList.title.toString(), style: TextStyle(color: Color(0xFF000000), fontSize: Dimensions.prayerListScreenContainerWidth16, fontWeight: FontWeight.bold),)
                      ),
                      SizedBox(height: Dimensions.prayerListScreenContainerHeight13,),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amberAccent, size: Dimensions.prayerListScreenContainerWidth13,),
                          SizedBox(width: Dimensions.prayerListScreenContainerWidth6,),
                          Text(scriptureList.date.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.prayerListScreenContainerWidth14, color: Color(0xFFBEC2CE)),),
                          SizedBox(width: Dimensions.prayerListScreenContainerWidth6,),
                          Text("|", style: TextStyle(fontWeight: FontWeight.w200, fontSize: Dimensions.prayerListScreenContainerWidth14, color: Color(0xFFBEC2CE)),),
                          SizedBox(width: Dimensions.prayerListScreenContainerWidth6,),
                          //Text("24 reviews", style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14, color: Color(0xFFBEC2CE)),),
                        ],
                      ),
                      SizedBox(height: Dimensions.prayerListScreenContainerHeight11,),
                      SizedBox(
                        width: Dimensions.prayerListScreenContainerWidth170,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(child: Container()),
                            Icon(Icons.bookmark_border_outlined, size: Dimensions.prayerListScreenContainerWidth19, color: Color(0xFFBEC2CE),)
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: Dimensions.prayerListScreenContainerHeight18,),
              Divider()
            ],
          ),
        );
      },
    );

}




