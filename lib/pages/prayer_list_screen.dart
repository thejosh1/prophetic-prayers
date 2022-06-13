import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prophetic_prayers/controller/scripture_controller.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/prayer_detail_screen.dart';
import '../models/prayers.dart';

class PrayerListScreen extends StatefulWidget {
  const PrayerListScreen({Key? key}) : super(key: key);

  @override
  State<PrayerListScreen> createState() => _PrayerListScreenState();
}

class _PrayerListScreenState extends State<PrayerListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Container(
               margin: EdgeInsets.only(left: 10, right: 16.7, top: 44),
               child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back, size: 18, color: Color(0xFF000000),)),
                   IconButton(onPressed: (){}, icon: Icon(Icons.more_vert, size: 20, color: Color(0xFF000000),))
                 ],
               ),
             ),
             Divider(
               height: 2,
               color: Color(0xFFEAECEF),
               thickness: 2,
             ),
             SizedBox(height: 22,),
             Container(
                 margin: EdgeInsets.only(left: 20),
                 child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                   children: [
                     Text("Scriptures For the Year", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFF1E2432)),),
                     SizedBox(height: 27,),
                     Container(
                       height: 532.5,
                       width: 335,
                       child: FutureBuilder(
                         future: readJson(),
                         builder: (context, snapshot) {
                           if(snapshot.hasError) {
                             return Center(child: Text("${snapshot.error}"));
                           } else if(snapshot.hasData){

                             var _scriptures = snapshot.data as List<Scripture>;

                             return buildScriptures(_scriptures);
                           } else {
                             return Center(child: Text("no data"),);
                           }
                         }
                       )
                     )
                   ],
                 )
             )
           ],
         ),
    );

  }

  Widget buildScriptures(List<Scripture> scriptures) => ListView.builder(
      itemCount: scriptures == null? 0: scriptures.length ,
      itemBuilder: (_, index) {
        final scriptureList = scriptures[index];
        return GestureDetector(
          onTap: (){
            Get.to(()=> const PrayerDetailScreen(), arguments: [
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
                    height: 110,
                    width: 90,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: AssetImage("images/ismael-paramo.jpg"),
                          fit: BoxFit.cover
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: 150,
                          child: Text(scriptureList.title.toString(), style: TextStyle(color: Color(0xFF000000), fontSize: 16, fontWeight: FontWeight.bold),)
                      ),
                      SizedBox(height: 13,),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amberAccent, size: 13.95,),
                          SizedBox(width: 6.2,),
                          Text(scriptureList.date.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFFBEC2CE)),),
                          SizedBox(width: 6.2,),
                          Text("|", style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14, color: Color(0xFFBEC2CE)),),
                          SizedBox(width: 6.2,),
                          //Text("24 reviews", style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14, color: Color(0xFFBEC2CE)),),
                        ],
                      ),
                      SizedBox(height: 11,),
                      SizedBox(
                        width: 170,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Row(
                            //   crossAxisAlignment: CrossAxisAlignment.end,
                            //   children: [
                            //     Text("from", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 14, color: Color(0xFFBEC2CE)),),
                            //     SizedBox(width: 4,),
                            //     Text("\$29", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF1F2533)),),
                            //   ],
                            // ),
                            Expanded(child: Container()),
                            Icon(Icons.bookmark_border_outlined, size: 19.26, color: Color(0xFFBEC2CE),)
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
              SizedBox(height: 18.5,),
              Divider()
            ],
          ),
        );
      },
    );

}




