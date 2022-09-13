import 'dart:convert';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/create_testimony_screen.dart';
import 'package:prophetic_prayers/pages/prayer_detail_screen.dart';
import 'package:prophetic_prayers/pages/screens/marriage_screen.dart';
import 'package:prophetic_prayers/pages/screens/prosperity_screen.dart';
import 'package:prophetic_prayers/pages/screens/warfare_screen.dart';
import 'package:prophetic_prayers/services/route_services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../controller/auth_controller.dart';
import '../models/prayers.dart';
import '../services/notify_services.dart';
import '../utils/dimensions.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  List<Scripture> scriptureList = [];
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    readJson();
    controller = ScrollController();
    NotifyServices.init(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() =>
      NotifyServices.onNotifications.stream.listen(onClickedNotification);
  void onClickedNotification(String? payload) => Get.to(() => const PrayerDetailScreen(), arguments: [payload]);
  Future<void> readJson() async {
    //read the json file
    await DefaultAssetBundle.of(context)
        .loadString("json/scriptures.json")
        .then((jsonData) {
      if(this.mounted) {
        setState(() {
          final list = json.decode(jsonData) as List<dynamic>;
          scriptureList = list.map((e) => Scripture.fromJson(e)).toList();
        });
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List daysofWeek = ["M", "T", "W", "T", "F", "S", "S"];
    List images = ["images/child(36).jpg", "images/ben-white.jpg", "images/sean-pollock.jpg", "images/alex-kotliarskyi.jpg", "images/ibrahim-boran.jpg", "images/adrianna-geo.jpg", "images/diana-simum.jpg", "images/child(40).jpg", "images/child(41).jpg", "images/child(42).jpg"];
    List daysInsWeek = [getTodaysDay()-1, getTodaysDay(), getTodaysDay()+1, getTodaysDay()+2, getTodaysDay()+3, getTodaysDay()+4, getTodaysDay()+5];
    List colorList = [Colors.brown, Colors.deepPurple, Colors.deepOrangeAccent, Colors.amber, Colors.green, Colors.deepOrangeAccent, Colors.orange];
    String currname = "Children";
    Color _randomColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    List planNames = ["Prosperity", "Academics", "Blessings", "Calling", "Career", "Discipline", "Health", "Lifestyle", "Marriage", "Warfare"];

    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor:  const Color(0xffF7F8FA),
      body: scriptureList.isNotEmpty ? ListView(
        controller: controller,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: Dimensions.Height10,),
                Container(
                  height: Dimensions.Height100*4,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.Width20+10),
                    color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: Dimensions.Height20,),
                      Container(
                        margin: EdgeInsets.only(left: Dimensions.Width20, right: Dimensions.Width20, top: Dimensions.Height20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("My Prayer For today", style: TextStyle(fontWeight: FontWeight.w600, fontSize: Dimensions.Width15+1, color: const Color(0xFF1E2432)),),
                            Text(DateFormat.MMMEd().format(DateTime.now()), style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.Width15+1, color: const Color(0xFF1E2432)),)
                          ],
                        ),
                      ),
                      // Padding(
                      //   padding: EdgeInsets.only(left: 20),
                      //   child: Text(prayertype, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                      // ),
                      SizedBox(height: Dimensions.Height10,),
                      InkWell(
                        splashColor: Colors.grey,
                        onTap: () {
                          Get.toNamed(RouteServices.PRAYERDETAIL, arguments: [
                            scriptureList[getTodaysDay()-1].id,
                            scriptureList[getTodaysDay()-1].prayerPoint,
                            scriptureList[getTodaysDay()-1].title,
                            scriptureList[getTodaysDay()-1].verse,
                            scriptureList[getTodaysDay()-1].date,
                            currname,
                            images[0]
                          ]);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: Dimensions.Width20),
                                width: Dimensions.Width150*2,
                                child: Text(
                                    scriptureList[getTodaysDay()-1].prayerPoint.toString(),
                                    style: TextStyle(fontSize: Dimensions.Width15+1, fontWeight: FontWeight.w800, color: const Color(0xFF1E2432))
                                )
                            ),
                            SizedBox(height: Dimensions.Height20,),
                            Padding(
                              padding: EdgeInsets.only(left: Dimensions.Width20),
                              child: Text(scriptureList[getTodaysDay()-1].title.toString(),
                                style: TextStyle(fontSize: Dimensions.Width15+1, fontWeight: FontWeight.w800, color: const Color(0xFF1E2432)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.Height20,),
                      Padding(
                        padding: EdgeInsets.only(left: Dimensions.Width20),
                        child: Row(
                          children: [
                            const Icon(Icons.list_sharp),
                            SizedBox(width: Dimensions.Width10),
                            Text("Prayers for the rest of the week", style: TextStyle(fontSize: Dimensions.Width15+1, fontWeight: FontWeight.w600, color: const Color(0xFF1E2432)),),
                          ],
                        ),
                      ),
                      SizedBox(height: Dimensions.Height20,),
                      SingleChildScrollView(
                        child: Container(
                          height: Dimensions.Height100,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  SizedBox(width: Dimensions.Width20,),
                                  Container(
                                    height: Dimensions.Height100,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: daysofWeek.length,
                                      itemBuilder: (_, index) {
                                         return Row(
                                           children: [
                                             InkWell(
                                               onTap: () {
                                                 Get.toNamed(RouteServices.PRAYERDETAIL, arguments: [
                                                   scriptureList[daysInsWeek[index]].id,
                                                   scriptureList[daysInsWeek[index]].prayerPoint,
                                                   scriptureList[daysInsWeek[index]].title,
                                                   scriptureList[daysInsWeek[index]].verse,
                                                   scriptureList[daysInsWeek[index]].date,
                                                   currname,
                                                   images[0]
                                                 ]);
                                               },
                                               child: Container(
                                                  height: Dimensions.Height100-10,
                                                  width: Dimensions.Width150,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimensions.Width20),
                                                    color: colorList[index]
                                                  ),
                                                  child: Center(
                                                    child: Container(
                                                      height: Dimensions.Height60,
                                                      width: Dimensions.Width90-30,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.white, width: Dimensions.Width3+2),
                                                        shape: BoxShape.circle
                                                      ),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: colorList[index],
                                                          shape: BoxShape.circle
                                                        ),
                                                        child: Center(
                                                          child: Text(daysofWeek[index], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                             ),
                                             SizedBox(width: Dimensions.Width10)
                                           ],
                                         );
                                        }
                                    ),
                                  ),
                                ],
                              );
                            }
                          ),
                        ),
                      ),
                      SizedBox(height: Dimensions.Height20,),
                    ],
                  ),
                ),
                SizedBox(height: Dimensions.Height20,),
                Container(
                  height: Dimensions.Height270-30,
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.Width30),
                      color: Colors.white
                  ),
                  child: Container(
                    margin: EdgeInsets.only(top: Dimensions.Height40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: Dimensions.Width20),
                          child: Text("Featured Plans", style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.Width20-4, color: const Color(0xFF1E2432)),),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            height: Dimensions.Height100+20,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 1,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      SizedBox(width: Dimensions.Width20,),
                                      Container(
                                        height: Dimensions.Height100+20,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          children: [
                                            GestureDetector(
                                              onTap: (){
                                                Get.to(()=> const PrayerScreen(), arguments: [planNames[0], images[1]]);
                                                setState(() {});
                                              },
                                              child: Stack(
                                                alignment: Alignment.bottomCenter,
                                                children: [
                                                  Container(
                                                    height: Dimensions.Height100,
                                                    width: Dimensions.Width90+10,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimensions.Width10),
                                                        color: Colors.grey,
                                                        image: DecorationImage(
                                                            image: AssetImage(images[0]),
                                                            fit: BoxFit.cover
                                                        )
                                                    ),
                                                  ),
                                                  Positioned(
                                                      bottom: 0,
                                                      child: Text(planNames[0], style: TextStyle(fontSize: Dimensions.Width10+2, fontWeight: FontWeight.bold, color: Colors.white),)
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.Width10),
                                            GestureDetector(
                                              onTap: (){
                                                Get.toNamed(RouteServices.ACADEMYSCRIPTURESCREEN, arguments: [planNames[1], images[1]]);
                                                setState(() {});
                                              },
                                              child: Stack(
                                                alignment: Alignment.bottomCenter,
                                                children: [
                                                  Container(
                                                    height: Dimensions.Height100,
                                                    width: Dimensions.Width90+10,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimensions.Width10),
                                                        color: Colors.grey,
                                                        image: DecorationImage(
                                                            image: AssetImage(images[1]),
                                                            fit: BoxFit.cover
                                                        )
                                                    ),
                                                  ),
                                                  Positioned(
                                                      bottom: 0,
                                                      child: Text(planNames[1], style: TextStyle(fontSize: Dimensions.Width10+2, fontWeight: FontWeight.bold, color: Colors.white),)
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.Width10),
                                            GestureDetector(
                                              onTap: (){
                                                Get.toNamed(RouteServices.BLESSINGSCRIPTURESCREEN, arguments: [planNames[2], images[2]]);
                                                setState(() {});
                                              },
                                              child: Stack(
                                                alignment: Alignment.bottomCenter,
                                                children: [
                                                  Container(
                                                    height: Dimensions.Height100,
                                                    width: Dimensions.Width90+10,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimensions.Width10),
                                                        color: Colors.grey,
                                                        image: DecorationImage(
                                                            image: AssetImage(images[2]),
                                                            fit: BoxFit.cover
                                                        )
                                                    ),
                                                  ),
                                                  Positioned(
                                                      bottom: 0,
                                                      child: Text(planNames[2], style: TextStyle(fontSize: Dimensions.Width10+2, fontWeight: FontWeight.bold, color: Colors.white),)
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.Width10),
                                            GestureDetector(
                                              onTap: (){
                                                Get.toNamed(RouteServices.CALLINGSCRIPTURESCREEN, arguments: [planNames[3], images[3]]);
                                                setState(() {});
                                              },
                                              child: Stack(
                                                alignment: Alignment.bottomCenter,
                                                children: [
                                                  Container(
                                                    height: Dimensions.Height100,
                                                    width: Dimensions.Width90+10,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimensions.Width10),
                                                        color: Colors.grey,
                                                        image: DecorationImage(
                                                            image: AssetImage(images[3]),
                                                            fit: BoxFit.cover
                                                        )
                                                    ),
                                                  ),
                                                  Positioned(
                                                      bottom: 0,
                                                      child: Text(planNames[3], style: TextStyle(fontSize: Dimensions.Width10+2, fontWeight: FontWeight.bold, color: Colors.white),)
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.Width10),
                                            GestureDetector(
                                              onTap: (){
                                                Get.toNamed(RouteServices.CAREERSCRIPTURESCREEN, arguments: [planNames[4], images[4]]);
                                                setState(() {});
                                              },
                                              child: Stack(
                                                alignment: Alignment.bottomCenter,
                                                children: [
                                                  Container(
                                                    height: Dimensions.Height100,
                                                    width: Dimensions.Width90+10,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimensions.Width10),
                                                        color: Colors.grey,
                                                        image: DecorationImage(
                                                            image: AssetImage(images[4]),
                                                            fit: BoxFit.cover
                                                        )
                                                    ),
                                                  ),
                                                  Positioned(
                                                      bottom: 0,
                                                      child: Text(planNames[4], style: TextStyle(fontSize: Dimensions.Width10+2, fontWeight: FontWeight.bold, color: Colors.white),)
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.Width10),
                                            GestureDetector(
                                              onTap: (){
                                                Get.toNamed(RouteServices.DISCIPLINESCRIPTURESCREEN, arguments: [planNames[5], images[5]]);
                                                setState(() {});
                                              },
                                              child: Stack(
                                                alignment: Alignment.bottomCenter,
                                                children: [
                                                  Container(
                                                    height: Dimensions.Height100,
                                                    width: Dimensions.Width90+10,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimensions.Width10),
                                                        color: Colors.grey,
                                                        image: DecorationImage(
                                                            image: AssetImage(images[5]),
                                                            fit: BoxFit.cover
                                                        )
                                                    ),
                                                  ),
                                                  Positioned(
                                                      bottom: 0,
                                                      child: Text(planNames[5], style: TextStyle(fontSize: Dimensions.Width10+2, fontWeight: FontWeight.bold, color: Colors.white),)
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.Width10),
                                            GestureDetector(
                                              onTap: (){
                                                Get.toNamed(RouteServices.HEALTHSCRIPTURESCREEN, arguments: [planNames[6], images[6]]);
                                                setState(() {});
                                              },
                                              child: Stack(
                                                alignment: Alignment.bottomCenter,
                                                children: [
                                                  Container(
                                                    height: Dimensions.Height100,
                                                    width: Dimensions.Width90+10,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimensions.Width10),
                                                        color: Colors.grey,
                                                        image: DecorationImage(
                                                            image: AssetImage(images[6]),
                                                            fit: BoxFit.cover
                                                        )
                                                    ),
                                                  ),
                                                  Positioned(
                                                      bottom: 0,
                                                      child: Text(planNames[6], style: TextStyle(fontSize: Dimensions.Width10+2, fontWeight: FontWeight.bold, color: Colors.white),)
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.Width10),
                                            GestureDetector(
                                              onTap: (){
                                                Get.toNamed(RouteServices.LIFESTYLESCRIPTURESCREEN, arguments: [planNames[7], images[7]]);
                                                setState(() {});
                                              },
                                              child: Stack(
                                                alignment: Alignment.bottomCenter,
                                                children: [
                                                  Container(
                                                    height: Dimensions.Height100,
                                                    width: Dimensions.Width90+10,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimensions.Width10),
                                                        color: Colors.grey,
                                                        image: DecorationImage(
                                                            image: AssetImage(images[7]),
                                                            fit: BoxFit.cover
                                                        )
                                                    ),
                                                  ),
                                                  Positioned(
                                                      bottom: 0,
                                                      child: Text(planNames[7], style: TextStyle(fontSize: Dimensions.Width10+2, fontWeight: FontWeight.bold, color: Colors.white),)
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.Width10),
                                            GestureDetector(
                                              onTap: (){
                                                Get.to(()=> const MarriageScreen(), arguments: [planNames[8],images[8]]);
                                                setState(() {});
                                              },
                                              child: Stack(
                                                alignment: Alignment.bottomCenter,
                                                children: [
                                                  Container(
                                                    height: Dimensions.Height100,
                                                    width: Dimensions.Width90+10,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimensions.Width10),
                                                        color: Colors.grey,
                                                        image: DecorationImage(
                                                            image: AssetImage(images[8]),
                                                            fit: BoxFit.cover
                                                        )
                                                    ),
                                                  ),
                                                  Positioned(
                                                      bottom: 0,
                                                      child: Text(planNames[8], style: TextStyle(fontSize: Dimensions.Width10+2, fontWeight: FontWeight.bold, color: Colors.white),)
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.Width10),
                                            GestureDetector(
                                              onTap: (){
                                                Get.to(()=> const WarfareScreen(), arguments: [planNames[9],images[9]]);
                                                setState(() {});
                                              },
                                              child: Stack(
                                                alignment: Alignment.bottomCenter,
                                                children: [
                                                  Container(
                                                    height: Dimensions.Height100,
                                                    width: Dimensions.Width90+10,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(Dimensions.Width10),
                                                        color: Colors.grey,
                                                        image: DecorationImage(
                                                            image: AssetImage(images[9]),
                                                            fit: BoxFit.cover
                                                        )
                                                    ),
                                                  ),
                                                  Positioned(
                                                      bottom: 0,
                                                      child: Text(planNames[9], style: TextStyle(fontSize: Dimensions.Width10+2, fontWeight: FontWeight.bold, color: Colors.white),)
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(width: Dimensions.Width10),
                                          ],
                                        ),
                                      ),
                                    ],
                                  );
                                }
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.Height20,),
                InkWell(
                  onTap: () {
                    Get.to(()=> const CreateTestimonyScreen(), arguments: ["Prophetic Prayers For Children"]);
                  },
                  child: Container(
                    height: Dimensions.Height270+100,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.Width30),
                      color: Colors.white
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: Dimensions.Width20, top: Dimensions.Height20, right: Dimensions.Width20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tesify", style: TextStyle(fontSize: Dimensions.Width10+2, fontWeight: FontWeight.w600, color: const Color(0xFF1E2432)),),
                              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_outlined, color: Colors.grey,))
                            ],
                          ),
                          SizedBox(height: Dimensions.Height20,),
                          Container(
                            height: Dimensions.Height100*2,
                            width: Dimensions.Width150*2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.Width20),
                              color: Colors.grey.withOpacity(0.4)
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Stack(
                                    alignment: Alignment.topCenter,
                                    children: [
                                      Container(
                                        height: Dimensions.Height100+50,
                                        width: Dimensions.Width90,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(Dimensions.Width10),
                                          color: Colors.white,
                                          boxShadow: const [
                                            BoxShadow(
                                              blurRadius: 1,
                                              spreadRadius: 1,
                                              offset: Offset(3,0),
                                              color: Colors.grey
                                            )
                                          ],
                                          image: const DecorationImage(
                                            image: AssetImage("images/welcome-one.png"),
                                            fit: BoxFit.cover
                                          )
                                        )
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: Dimensions.Height100+50,
                                    width: Dimensions.Width90,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("Do you have a testimony",
                                          style:
                                          TextStyle(fontSize: Dimensions.Width10+2, fontWeight: FontWeight.w300, color: Colors.black54),
                                        ),
                                        SizedBox(height: Dimensions.Height20,),
                                        Text("Start thanking God",
                                          style: TextStyle(fontWeight: FontWeight.w300, fontSize: Dimensions.Width10+2, color: const Color(0xFF1E2432)),
                                        ),
                                        SizedBox(height: Dimensions.Height20,),
                                        Container(
                                          height: Dimensions.Height40,
                                          width: Dimensions.Width90-10,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(Dimensions.Width90-10),
                                            color: Colors.grey
                                          ),
                                          child: Center(
                                            child: Text("Testify Now", style: TextStyle(fontSize: Dimensions.Width10+2, fontWeight: FontWeight.bold, color: Color(0xFF1E2432)),),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ),
                          ),
                          SizedBox(height: Dimensions.Height20,),

                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: Dimensions.Height20,),
                //social media
                Container(
                  height: Dimensions.Height270-50,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.Width30),
                    color: _randomColor
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: Dimensions.Width20, right: Dimensions.Width20, top: Dimensions.Height20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Get.toNamed(RouteServices.ABOUTSCREEN);
                              },
                              child: Container(
                                  height: Dimensions.Height100+50,
                                  width: Dimensions.Width90,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.Width10),
                                      color: Colors.white,
                                  )
                              ),
                            ),
                            Positioned(
                              bottom: Dimensions.Height40+10,
                              child: Icon(Icons.follow_the_signs_sharp, color: Colors.grey, size: Dimensions.Width15+3,),
                            )
                          ],
                        ),
                        Container(
                          width: Dimensions.Width150,
                          height: Dimensions.Height100+50,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Want to know more about us", style: TextStyle(fontSize: Dimensions.Width15+1, fontWeight: FontWeight.bold, color: Colors.white),),
                              SizedBox(height: Dimensions.Height20,),
                              Text("Follow us on all our socials", style: TextStyle(fontSize: Dimensions.Width10+2, fontWeight: FontWeight.bold, color: Colors.white)),
                              SizedBox(height: Dimensions.Height10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () async{
                                      //link to social media app or website
                                      final url = Uri.parse("https://facebook.com");

                                      if(await canLaunchUrl(url)) {
                                        launchUrl(url);
                                      } else {
                                        print("cannot launch");
                                      }

                                    },
                                    child: Container(
                                      height: Dimensions.Height20,
                                      width: Dimensions.Width20,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          image: AssetImage(
                                            "images/facebook-logo.png"
                                          ),
                                          fit: BoxFit.cover
                                        )
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.Width20*2),
                                  GestureDetector(
                                    onTap: () async{
                                      //link to social media app or website
                                      final url = Uri.parse("https://instagram.com");

                                      if(await canLaunchUrl(url)) {
                                      launchUrl(url,);
                                      } else {
                                      print("cannot launch");
                                      }
                                    },
                                    child: Container(
                                      height: Dimensions.Height20,
                                      width: Dimensions.Width20,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "images/instagrams-logo.png"
                                              ),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.Width20*2),
                                  GestureDetector(
                                    onTap: () async{
                                      //link to social media app or website
                                      final url = Uri.parse("https://twitter.com");

                                        if(await canLaunchUrl(url)) {
                                          launchUrl(url,);
                                        } else {
                                          print("cannot launch");
                                        }
                                    },
                                    child: Container(
                                      height: Dimensions.Height20,
                                      width: Dimensions.Width20,
                                      decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(
                                              image: AssetImage(
                                                  "images/twitter-logo.png"
                                              ),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ]
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ): SizedBox(
        width: size.width,
        child: Center(
          child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.black54),),),
      )
    );
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

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AuthController.instance.auth.currentUser;
    // TODO: implement build
    return Container(
      height: Dimensions.Height100,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 0.5,
            spreadRadius: 0.5,
            offset: Offset(0, 3),
            color: Colors.transparent
          )
        ]
      ),
      padding: EdgeInsets.only(left: Dimensions.Width20+4, right: Dimensions.Width20+4, top: Dimensions.Height40+6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
              future: FirebaseFirestore.instance.collection("users").doc(user?.uid).get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Welcome", style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.Width20+4),);
                } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!.exists) {
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return Text("Welcome ${data["name"]}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.Width15+3),);
                }
                return Text("Welcome", style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.Width15+3),);
              }
          ),
          FutureBuilder(
              future: FirebaseFirestore.instance.collection("users").doc(user?.uid).get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: Dimensions.Height20+10,
                    width: Dimensions.Width30,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("images/Icon-48.png")
                        )
                    ),
                  );
                } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!.exists) {
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return Container(
                    height: Dimensions.Height20+10,
                    width: Dimensions.Width30,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage("${data["imagePath"]}"),
                        fit: BoxFit.cover
                      )
                    ),
                  );
                }
                return Container(
                  height: Dimensions.Height20+10,
                  width: Dimensions.Width30,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("images/Icon-48.png")
                    )
                  ),
                );
              }
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(Dimensions.Height100+26);
}
