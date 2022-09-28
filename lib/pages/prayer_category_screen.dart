import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prophetic_prayers/pages/prayer_detail_screen.dart';
import 'package:prophetic_prayers/utils/dimensions.dart';

import '../controller/auth_controller.dart';
import '../models/prayers.dart';
import '../services/route_services.dart';

class PrayerCategoryScreen extends StatefulWidget {
  const PrayerCategoryScreen({Key? key}) : super(key: key);

  @override
  State<PrayerCategoryScreen> createState() => _PrayerCategoryScreenState();
}

class _PrayerCategoryScreenState extends State<PrayerCategoryScreen> {
  List<Scripture> scriptureList = [];
  @override
  void initState() {
    super.initState();
    readJson();
    scriptureList;
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
    PageController pageController = PageController(viewportFraction: 0.8 );
    List monthNames = ["January", "February", "March", "April", "May", "June","July", "August", "September", "October", "November", "December"];
    List imageList = [Colors.brown, Colors.deepPurple, Colors.deepOrangeAccent, Colors.amber, Colors.green, Colors.deepOrangeAccent, Colors.orange, Colors.amber, Colors.green, Colors.deepOrangeAccent, Colors.orange, Colors.brown, Colors.deepPurple, Colors.deepOrangeAccent,];
    List colorList = ["images/image1.jpg", "images/famimages2.jfif", "images/famimages.jfif", "images/pastor-conducts.jpg", "images/office.jfif", "images/discipline.jpg", "images/health.png", "images/bible.jpg", "images/summer-seascape.jpg", "images/children.png", "images/cute-boy.jpg", "images/welcomeImages.jfif",];
    final user = AuthController.instance.auth.currentUser;
    RxString currname = "January".obs;
    RxBool isTapped = false.obs;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: scriptureList.isNotEmpty ? SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: Dimensions.Height100,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        blurRadius: 0.5,
                        spreadRadius: 0.5,
                        offset: Offset(0, 3),
                        color: Colors.transparent,
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
                          return const Text("Welcome", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),);
                        } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!.exists) {
                          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                          return Text("Welcome ${data["name"]}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),);
                        }
                        return const Text("Welcome", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),);
                      }
                  ),
                  FutureBuilder(
                      future: FirebaseFirestore.instance.collection("users").doc(user?.uid).get(),
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return Container(
                            height: Dimensions.Height20+10,
                            width: Dimensions.Width20+10,
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
                            width: Dimensions.Width20+10,
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
                          width: Dimensions.Width20+10,
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
            ),
            SizedBox(height: Dimensions.Height20,),
            //pageview builder
            Container(
              height: Dimensions.Height270-20,
              color: Colors.white,
              child: PageView.builder(
                  controller: pageController,
                  itemCount: monthNames.length,
                  pageSnapping: true,
                  itemBuilder: (BuildContext context, index) {
                    return Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(RouteServices.PRAYERLISTSCREEN, arguments: [
                                  monthNames[index],
                                  imageList[index],
                                  "Children"
                                ]);
                              },
                              child: Container(
                                height: Dimensions.Height100*2,
                                width: Dimensions.Width170+110,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(Dimensions.Width20),
                                  color: Colors.grey,
                                  image: DecorationImage(
                                    image: AssetImage(colorList[index]),
                                    fit: BoxFit.cover
                                  )
                                ),
                                // child: Center(
                                //   child: Text(monthNames[index], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: Colors.white),),
                                // )
                              ),
                            ),
                            SizedBox(height: Dimensions.Height20,),
                            Text(monthNames[index], style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.Width16+2),)
                          ],
                        ),

                      ],
                    );
              }),
            ),
            SizedBox(height: Dimensions.Height7-2,),
            Container(
              margin: EdgeInsets.only(left: Dimensions.Width20+4, right: Dimensions.Width10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: Dimensions.Height20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat.MMMEd().format(DateTime.now()), style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.Width16+2),),
                      GestureDetector(
                        onTap: () {
                          isTapped.value = !isTapped.value;
                          print(isTapped.value.toString());
                        },
                        child: Row(
                          children: [
                            Text("Expand", style: TextStyle(fontSize: Dimensions.Width16+2, fontWeight: FontWeight.bold),),
                            SizedBox(width: Dimensions.Width10,),
                            Obx(()=>  isTapped.value == false ? Icon(Icons.arrow_forward_ios_outlined, size: Dimensions.Width16+2,): Icon(Icons.arrow_drop_down, size: Dimensions.Width16+2,))
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: Dimensions.Height20,),
                   Obx(()=> isTapped.value == false ? Column(
                     children: [
                       InkWell(
                         splashColor: Colors.grey,
                         onTap: () {
                           Get.to(()=> const PrayerDetailScreen(), arguments: [
                             scriptureList[getTodaysDay()-1].id,
                             scriptureList[getTodaysDay()-1].prayerPoint,
                             scriptureList[getTodaysDay()-1].title,
                             scriptureList[getTodaysDay()-1].verse,
                             scriptureList[getTodaysDay()-1].date,
                             currname.value,
                             "images/child(36).jpg"
                           ]);
                         },
                         child: Row(
                           children: [
                             Container(
                               height: Dimensions.Height60+20,
                               width: Dimensions.Width90-10,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(Dimensions.Width20),
                                   border: Border.all(color: Colors.grey, width: Dimensions.Width2),
                                   color: const Color(0xffF7F8FA)
                               ),
                               child: Center(
                                   child: Text(scriptureList[getTodaysDay()-1].verse.toString()[0], style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.Width20+4))
                               ),
                             ),
                             Expanded(
                                 child: Container(
                                   height: Dimensions.Height60+20,
                                   child: Padding(
                                     padding: EdgeInsets.only(left: Dimensions.Width10),
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(scriptureList[getTodaysDay()-1].verse.toString(), maxLines: 1,overflow: TextOverflow.ellipsis,),
                                         SizedBox(height: Dimensions.Height2+1,),
                                         Text(scriptureList[getTodaysDay()-1].title.toString()),
                                         SizedBox(height: Dimensions.Height2+1,),
                                         Text(scriptureList[getTodaysDay()-1].date.toString()),
                                         SizedBox(height: Dimensions.Height2+1),
                                         Row(
                                           children: [
                                             Wrap(children:
                                             List.generate(5, (index) => Icon(Icons.star, color: Colors.amberAccent, size: Dimensions.Width16-1,))
                                             ),
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                 )
                             )
                           ],
                         ),
                       ),
                       SizedBox(height: Dimensions.Height20,),
                       InkWell(
                         splashColor: Colors.grey,
                         onTap: () {
                           Get.to(()=> const PrayerDetailScreen(), arguments: [
                             scriptureList[getTodaysDay()].id,
                             scriptureList[getTodaysDay()].prayerPoint,
                             scriptureList[getTodaysDay()].title,
                             scriptureList[getTodaysDay()].verse,
                             scriptureList[getTodaysDay()].date,
                             currname.value,
                             "images/child(36).jpg"
                           ]);
                         },
                         child: Row(
                           children: [
                             Container(
                               height: Dimensions.Height60+20,
                               width: Dimensions.Width90-10,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(Dimensions.Width20),
                                   border: Border.all(color: Colors.grey, width: Dimensions.Width2),
                                   color: const Color(0xffF7F8FA)
                               ),
                               child: Center(
                                   child: Text(scriptureList[getTodaysDay()].verse.toString()[0], style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.Width20+4))
                               ),
                             ),
                             Expanded(
                                 child: Container(
                                   height: Dimensions.Height60+20,
                                   child: Padding(
                                     padding: EdgeInsets.only(left: Dimensions.Width10),
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(scriptureList[getTodaysDay()].verse.toString(), maxLines: 1,overflow: TextOverflow.ellipsis,),
                                         SizedBox(height: Dimensions.Height2+1,),
                                         Text(scriptureList[getTodaysDay()].title.toString()),
                                         SizedBox(height: Dimensions.Height2+1,),
                                         Text(scriptureList[getTodaysDay()].date.toString()),
                                         SizedBox(height: Dimensions.Height2+1,),
                                         Row(
                                           children: [
                                             Wrap(children:
                                             List.generate(5, (index) => Icon(Icons.star, color: Colors.amberAccent, size: Dimensions.Width16-1,))
                                             ),
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                 )
                             )
                           ],
                         ),
                       ),
                       SizedBox(height: Dimensions.Height20,),
                       InkWell(
                         splashColor: Colors.grey,
                         onTap: (){
                           Get.to(()=> const PrayerDetailScreen(), arguments: [
                             scriptureList[getTodaysDay()+1].id,
                             scriptureList[getTodaysDay()+1].prayerPoint,
                             scriptureList[getTodaysDay()+1].title,
                             scriptureList[getTodaysDay()+1].verse,
                             scriptureList[getTodaysDay()+1].date,
                             currname.value,
                             "images/child(36).jpg"
                           ]);
                         },
                         child: Row(
                           children: [
                             Container(
                               height: Dimensions.Height60+20,
                               width: Dimensions.Width90-10,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(Dimensions.Width20),
                                   border: Border.all(color: Colors.grey, width: Dimensions.Width2),
                                   color: const Color(0xffF7F8FA)
                               ),
                               child: Center(
                                   child: Text(scriptureList[getTodaysDay()+1].verse.toString()[0], style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.Width20+4),)
                               ),
                             ),
                             Expanded(
                                 child: Container(
                                   height: Dimensions.Height60+20,
                                   child: Padding(
                                     padding: EdgeInsets.only(left: Dimensions.Width10),
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(scriptureList[getTodaysDay()+1].verse.toString(), maxLines: 1,overflow: TextOverflow.ellipsis,),
                                         SizedBox(height: Dimensions.Height2+1,),
                                         Text(scriptureList[getTodaysDay()+1].title.toString()),
                                         SizedBox(height: Dimensions.Height2+1,),
                                         Text(scriptureList[getTodaysDay()+1].date.toString()),
                                         SizedBox(height: Dimensions.Height2+1,),
                                         Row(
                                           children: [
                                             Wrap(children:
                                             List.generate(5, (index) => Icon(Icons.star, color: Colors.amberAccent, size: Dimensions.Width16-1,))
                                             ),
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                 )
                             )
                           ],
                         ),
                       ),
                     ],
                   ):Column(
                       children: [
                         InkWell(
                           splashColor: Colors.grey,
                           onTap: () {
                             Get.to(()=> const PrayerDetailScreen(), arguments: [
                               scriptureList[getTodaysDay()-1].id,
                               scriptureList[getTodaysDay()-1].prayerPoint,
                               scriptureList[getTodaysDay()-1].title,
                               scriptureList[getTodaysDay()-1].verse,
                               scriptureList[getTodaysDay()-1].date,
                               currname.value,
                               "images/child(36).jpg"
                             ]);
                           },
                           child: Row(
                           children: [
                             Container(
                               height: Dimensions.Height60+20,
                               width: Dimensions.Width90-10,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(Dimensions.Width20),
                                   border: Border.all(color: Colors.grey, width: Dimensions.Width2),
                                   color: const Color(0xffF7F8FA)
                               ),
                               child: Center(
                                   child: Text(scriptureList[getTodaysDay()-1].verse.toString()[0], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24))
                               ),
                             ),
                             Expanded(
                                 child: Container(
                                   height: Dimensions.Height60+20,
                                   child: Padding(
                                     padding: EdgeInsets.only(left: Dimensions.Width10),
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(scriptureList[getTodaysDay()-1].verse.toString(), maxLines: 1,overflow: TextOverflow.ellipsis,),
                                         SizedBox(height: Dimensions.Height2+1,),
                                         Text(scriptureList[getTodaysDay()-1].title.toString()),
                                         SizedBox(height: Dimensions.Height2+1),
                                         Text(scriptureList[getTodaysDay()-1].date.toString()),
                                         SizedBox(height: Dimensions.Height2+1),
                                         Row(
                                           children: [
                                             Wrap(children:
                                             List.generate(5, (index) => Icon(Icons.star, color: Colors.amberAccent, size: Dimensions.Width16-1,))
                                             ),
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                 )
                             )
                           ],
                       ),
                         ),
                         SizedBox(height: Dimensions.Height20,),
                         InkWell(
                           splashColor: Colors.grey,
                           onTap: () {
                             Get.to(()=> const PrayerDetailScreen(), arguments: [
                               scriptureList[getTodaysDay()].id,
                               scriptureList[getTodaysDay()].prayerPoint,
                               scriptureList[getTodaysDay()].title,
                               scriptureList[getTodaysDay()].verse,
                               scriptureList[getTodaysDay()].date,
                               currname.value,
                               "images/child(36).jpg"
                             ]);
                           },
                           child: Row(
                           children: [
                             Container(
                               height: Dimensions.Height60+20,
                               width: Dimensions.Width90-10,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(Dimensions.Width20),
                                   border: Border.all(color: Colors.grey, width: Dimensions.Width2),
                                   color: const Color(0xffF7F8FA)
                               ),
                               child: Center(
                                   child: Text(scriptureList[getTodaysDay()].verse.toString()[0], style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.Width20+4))
                               ),
                             ),
                             Expanded(
                                 child: Container(
                                   height: Dimensions.Height60+20,
                                   child: Padding(
                                     padding: EdgeInsets.only(left: Dimensions.Width10),
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(scriptureList[getTodaysDay()].verse.toString(), maxLines: 1,overflow: TextOverflow.ellipsis,),
                                         SizedBox(height: Dimensions.Height2+1,),
                                         Text(scriptureList[getTodaysDay()].title.toString()),
                                         SizedBox(height: Dimensions.Height2+1,),
                                         Text(scriptureList[getTodaysDay()].date.toString()),
                                         SizedBox(height: Dimensions.Height2+1,),
                                         Row(
                                           children: [
                                             Wrap(children:
                                             List.generate(5, (index) => Icon(Icons.star, color: Colors.amberAccent, size: Dimensions.Width16-1,))
                                             ),
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                 )
                             )
                           ],
                       ),
                         ),
                         SizedBox(height: Dimensions.Height20,),
                         InkWell(
                           splashColor: Colors.grey,
                           onTap: () {
                             Get.to(()=> const PrayerDetailScreen(), arguments: [
                               scriptureList[getTodaysDay()+1].id,
                               scriptureList[getTodaysDay()+1].prayerPoint,
                               scriptureList[getTodaysDay()+1].title,
                               scriptureList[getTodaysDay()+1].verse,
                               scriptureList[getTodaysDay()+1].date,
                               currname.value,
                               "images/child(36).jpg"
                             ]);
                           },
                           child: Row(
                           children: [
                             Container(
                               height: Dimensions.Height60+20,
                               width: Dimensions.Width90-10,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(Dimensions.Width20),
                                   border: Border.all(color: Colors.grey, width: Dimensions.Width2),
                                   color: const Color(0xffF7F8FA)
                               ),
                               child: Center(
                                   child: Text(scriptureList[getTodaysDay()+1].verse.toString()[0], style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.Width20+4),)
                               ),
                             ),
                             Expanded(
                                 child: Container(
                                   height: Dimensions.Height40*2,
                                   child: Padding(
                                     padding: EdgeInsets.only(left: Dimensions.Width10),
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(scriptureList[getTodaysDay()+1].verse.toString(), maxLines: 1,overflow: TextOverflow.ellipsis,),
                                         SizedBox(height: Dimensions.Height2+1,),
                                         Text(scriptureList[getTodaysDay()+1].title.toString()),
                                         SizedBox(height: Dimensions.Height2+1,),
                                         Text(scriptureList[getTodaysDay()+1].date.toString()),
                                         SizedBox(height: Dimensions.Height2+1,),
                                         Row(
                                           children: [
                                             Wrap(children:
                                             List.generate(5, (index) => Icon(Icons.star, color: Colors.amberAccent, size: Dimensions.Width16-1,))
                                             ),
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                 )
                             )
                           ],
                       ),
                         ),
                         SizedBox(height: Dimensions.Height20,),
                         InkWell(
                           splashColor: Colors.grey,
                           onTap: (){
                             Get.to(()=> const PrayerDetailScreen(), arguments: [
                               scriptureList[getTodaysDay()+2].id,
                               scriptureList[getTodaysDay()+2].prayerPoint,
                               scriptureList[getTodaysDay()+2].title,
                               scriptureList[getTodaysDay()+2].verse,
                               scriptureList[getTodaysDay()+2].date,
                               currname.value,
                               "images/child(36).jpg"
                             ]);
                           },
                           child: Row(
                           children: [
                             Container(
                               height: Dimensions.Height60+20,
                               width: Dimensions.Width90-10,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(Dimensions.Width20),
                                   border: Border.all(color: Colors.grey, width: Dimensions.Width2),
                                   color: const Color(0xffF7F8FA)
                               ),
                               child: Center(
                                   child: Text(scriptureList[getTodaysDay()+2].verse.toString()[0], style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.Width20+4),)
                               ),
                             ),
                             Expanded(
                                 child: Container(
                                   height: Dimensions.Height60+20,
                                   child: Padding(
                                     padding: EdgeInsets.only(left: Dimensions.Width10),
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(scriptureList[getTodaysDay()+2].verse.toString(), maxLines: 1,overflow: TextOverflow.ellipsis,),
                                         SizedBox(height: Dimensions.Height2+1,),
                                         Text(scriptureList[getTodaysDay()+2].title.toString()),
                                         SizedBox(height: Dimensions.Height2+1,),
                                         Text(scriptureList[getTodaysDay()+2].date.toString()),
                                         SizedBox(height: Dimensions.Height2+1,),
                                         Row(
                                           children: [
                                             Wrap(children:
                                             List.generate(5, (index) => Icon(Icons.star, color: Colors.amberAccent, size: Dimensions.Width16-1,))
                                             ),
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                 )
                             )
                           ],
                       ),
                         ),
                         SizedBox(height: Dimensions.Height20,),
                         InkWell(
                           splashColor: Colors.grey,
                           onTap: () {
                             Get.to(()=> const PrayerDetailScreen(), arguments: [
                               scriptureList[getTodaysDay()+3].id,
                               scriptureList[getTodaysDay()+3].prayerPoint,
                               scriptureList[getTodaysDay()+3].title,
                               scriptureList[getTodaysDay()+3].verse,
                               scriptureList[getTodaysDay()+3].date,
                               currname.value,
                               "images/child(36).jpg"
                             ]);
                           },
                           child: Row(
                           children: [
                             Container(
                               height: Dimensions.Height60+20,
                               width: Dimensions.Width90-10,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(Dimensions.Width20),
                                   border: Border.all(color: Colors.grey, width: Dimensions.Width2),
                                   color: const Color(0xffF7F8FA)
                               ),
                               child: Center(
                                   child: Text(scriptureList[getTodaysDay()+3].verse.toString()[0], style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.Width20+4),)
                               ),
                             ),
                             Expanded(
                                 child: Container(
                                   height: Dimensions.Height60+20,
                                   child: Padding(
                                     padding: EdgeInsets.only(left: Dimensions.Width10),
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(scriptureList[getTodaysDay()+3].verse.toString(), maxLines: 1,overflow: TextOverflow.ellipsis,),
                                         SizedBox(height: Dimensions.Height2+1,),
                                         Text(scriptureList[getTodaysDay()+3].title.toString()),
                                         SizedBox(height: Dimensions.Height2+1,),
                                         Text(scriptureList[getTodaysDay()+3].date.toString()),
                                         SizedBox(height: Dimensions.Height2+1,),
                                         Row(
                                           children: [
                                             Wrap(children:
                                             List.generate(5, (index) => Icon(Icons.star, color: Colors.amberAccent, size: Dimensions.Width16-1,))
                                             ),
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                 )
                             )
                           ],
                       ),
                         ),
                         SizedBox(height: Dimensions.Height20,),
                         InkWell(
                           splashColor: Colors.grey,
                           onTap: () {
                             Get.to(()=> const PrayerDetailScreen(), arguments: [
                               scriptureList[getTodaysDay()+4].id,
                               scriptureList[getTodaysDay()+4].prayerPoint,
                               scriptureList[getTodaysDay()+4].title,
                               scriptureList[getTodaysDay()+4].verse,
                               scriptureList[getTodaysDay()+4].date,
                               currname.value,
                               "images/child(36).jpg"
                             ]);
                           },
                           child: Row(
                           children: [
                             Container(
                               height: Dimensions.Height60+20,
                               width: Dimensions.Width90-10,
                               decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(Dimensions.Width20),
                                   border: Border.all(color: Colors.grey, width: Dimensions.Width2),
                                   color: const Color(0xffF7F8FA)
                               ),
                               child: Center(
                                   child: Text(scriptureList[getTodaysDay()+4].verse.toString()[0], style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.Width20+4),)
                               ),
                             ),
                             Expanded(
                                 child: Container(
                                   height: Dimensions.Height100-10,
                                   child: Padding(
                                     padding: EdgeInsets.only(left: Dimensions.Width10),
                                     child: Column(
                                       mainAxisAlignment: MainAxisAlignment.start,
                                       crossAxisAlignment: CrossAxisAlignment.start,
                                       children: [
                                         Text(scriptureList[getTodaysDay()+4].verse.toString(), maxLines: 1,overflow: TextOverflow.ellipsis,),
                                         SizedBox(height: Dimensions.Height2*2,),
                                         Text(scriptureList[getTodaysDay()+4].title.toString()),
                                         SizedBox(height: Dimensions.Height2*2,),
                                         Text(scriptureList[getTodaysDay()+4].date.toString()),
                                         SizedBox(height: Dimensions.Height2*2,),
                                         Row(
                                           children: [
                                             Wrap(children:
                                             List.generate(5, (index) => Icon(Icons.star, color: Colors.amberAccent, size: Dimensions.Width16-1,))
                                             ),
                                           ],
                                         ),
                                       ],
                                     ),
                                   ),
                                 )
                             )
                           ],
                       ),
                         ),
                         SizedBox(height: Dimensions.Height20,),
                       ])
                   ),
                  SizedBox(height: Dimensions.Height20,)
                ],
              ),
            )
          ],
        ),
      ):SizedBox(
        width: size.width,
        child: const Center(
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
