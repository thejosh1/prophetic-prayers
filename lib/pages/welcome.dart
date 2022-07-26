import 'dart:convert';
import 'dart:math' as math;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/prayer_detail_screen.dart';
import 'package:prophetic_prayers/pages/start_plan_screen.dart';
import 'package:prophetic_prayers/pages/testimony_detail_page.dart';
import 'package:prophetic_prayers/services/testimony_services.dart';

import '../controller/auth_controller.dart';
import '../models/prayers.dart';
import '../services/notify_services.dart';
import '../utils/shared_preferences.dart';
import 'choose_plan_screen.dart';

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

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
    Size size = MediaQuery.of(context).size;
    List daysofWeek = ["M", "T", "W", "T", "F", "S", "S"];
    List images = ["images/child(36).jpg", "images/ben-white.jpg", "images/sean-pollock.jpg", "images/alex-kotliarskyi.jpg", "images/ibrahim-boran.jpg"];
    List daysInsWeek = [getTodaysDay()-1, getTodaysDay(), getTodaysDay()+1, getTodaysDay()+2, getTodaysDay()+3, getTodaysDay()+4, getTodaysDay()+5];
    List colorList = [Colors.brown, Colors.deepPurple, Colors.deepOrangeAccent, Colors.amber, Colors.green, Colors.deepOrangeAccent, Colors.orange];
    String currname = "Children";
    Color _randomColor = Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
    List planNames = ["Children", "Marriage", "Business", "Work", "Finance"];
    String prayertype = AppPreferences.getPrayertype() ?? " ";
    List index = [0, 1, 2, 3, 4];
    final localizations = MaterialLocalizations.of(context);

    Future<void> _openTimePicker(BuildContext context) async {
      final TimeOfDay? time = await showTimePicker(
          context: context,
          // initialEntryMode:
          // TimePickerEntryMode.input,
          initialTime: TimeOfDay.now()
      );
      if(time !=null) {
        //set a scheduled notification based on the time
        final _time = localizations.formatTimeOfDay(time).split(" ")[0];
        int formattedtime = int.parse(_time.split(":")[0]);
        print(formattedtime);
        setState(() {
          NotifyServices.showScheduledNotification(
            title: "It's time to pray",
            body: scriptureList[getTodaysDay()-1].prayerPoint.toString(),
            payload: scriptureList[getTodaysDay()-1].prayerPoint.toString(),
            //to implement this subtract the time the user chooses from the current time and pass it as a duration in datetime.add
            scheduledDate: DateTime(int.parse(_time)),
          );
        });
      }
    }
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor:  const Color(0xffF7F8FA),
      body: scriptureList.isNotEmpty ? ListView(
        controller: controller,
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Container(
                  height: 400,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20,),
                      Container(
                        margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("My Prayer For today", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF1E2432)),),
                            Text(DateFormat.MMMEd().format(DateTime.now()), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E2432)),)
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(prayertype, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                      ),
                      SizedBox(height: 10,),
                      InkWell(
                        splashColor: Colors.grey,
                        onTap: () {
                          Get.to(()=> const PrayerDetailScreen(), arguments: [
                            scriptureList[getTodaysDay()-1].id,
                            scriptureList[getTodaysDay()-1].prayerPoint,
                            scriptureList[getTodaysDay()-1].title,
                            scriptureList[getTodaysDay()-1].verse,
                            scriptureList[getTodaysDay()-1].date,
                            currname
                          ]);
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin: EdgeInsets.only(left: 20),
                                width: 300,
                                child: Text(
                                    scriptureList[getTodaysDay()-1].prayerPoint.toString(),
                                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1E2432))
                                )
                            ),
                            SizedBox(height: 20,),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(scriptureList[getTodaysDay()-1].title.toString(),
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800, color: Color(0xFF1E2432)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          children: const [
                            Icon(Icons.list_sharp),
                            SizedBox(width: 10),
                            Text("Prayers for the rest of the week", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1E2432)),),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      SingleChildScrollView(
                        child: Container(
                          height: 100,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: 1,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  SizedBox(width: 20,),
                                  Container(
                                    height: 100,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      shrinkWrap: true,
                                      itemCount: daysofWeek.length,
                                      itemBuilder: (_, index) {
                                         return Row(
                                           children: [
                                             InkWell(
                                               onTap: () {
                                                 Get.to(() => PrayerDetailScreen(), arguments: [
                                                   scriptureList[daysInsWeek[index]].id,
                                                   scriptureList[daysInsWeek[index]].prayerPoint,
                                                   scriptureList[daysInsWeek[index]].title,
                                                   scriptureList[daysInsWeek[index]].verse,
                                                   scriptureList[daysInsWeek[index]].date,
                                                   currname
                                                 ]);
                                               },
                                               child: Container(
                                                  height: 90,
                                                  width: 150,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(20),
                                                    color: colorList[index]
                                                  ),
                                                  child: Center(
                                                    child: Container(
                                                      height: 60,
                                                      width: 60,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(color: Colors.white, width: 5),
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
                                             SizedBox(width: 10)
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
                      SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Row(
                                children: const [
                                  Icon(Icons.notifications, color: Color(0xFF1E2432),),
                                  SizedBox(width: 5,),
                                  Text("Add Reminder", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E2432)),)
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                StreamBuilder(
                  stream: TestimonyServices.showTestimony(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return const SizedBox(height: 0,);
                    }
                    final snapdata = snapshot.data!.docs;
                    return snapdata.isNotEmpty ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 320,
                          width: size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white,
                          ),
                          child: Container(
                            margin: EdgeInsets.only(left: 20, right: 20, top: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text("Our Testimonies", style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                        color: Color(0xFF1E2432)),),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                SingleChildScrollView(
                                  child: Container(
                                    height: 240,
                                    child: ListView.builder(
                                      itemCount: snapdata.take(3).length,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (BuildContext context, index) {
                                        return FutureBuilder(
                                          future: FirebaseFirestore.instance.collection("users").doc(snapdata[index]["useruid"].toString()).get(),
                                          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot>snapshot) {
                                            if(snapshot.connectionState == ConnectionState.waiting) {
                                              return Center(child: CircularProgressIndicator(),);
                                            } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!.exists) {
                                              Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                                              return Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          Get.to(()=> const TestimonyDetailPage());
                                                          },
                                                        child: Container(
                                                          height: 200,
                                                          width: 120,
                                                          decoration: BoxDecoration(
                                                            borderRadius: BorderRadius.circular(10),
                                                            image: DecorationImage(
                                                              image: NetworkImage("${data["imagePath"]}"),
                                                              fit: BoxFit.cover
                                                            )
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10,),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 2,
                                                            width: 2,
                                                            decoration: const BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              color: Colors.red
                                                            ),
                                                          ),
                                                          SizedBox(width: 3,),
                                                          Text("${data["name".split(" ")[0]]}", style: TextStyle(fontWeight: FontWeight.w600),),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(width: 10,)
                                                ],
                                              );
                                            }
                                            return SizedBox();
                                          }
                                        );
                                      }
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 20,)
                      ],
                    ) : SizedBox();

                  }
                ),
                Container(
                  height: 460,
                  width: size.width,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 20, top: 40),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("My plans", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16, color: Color(0xFF1E2432)),),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: (){
                              },
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Container(
                                    height: 150,
                                    width: 150,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey,
                                        image: const DecorationImage(
                                            image: AssetImage("images/child(36).jpg"),
                                            fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                  const Positioned(
                                      bottom: 0,
                                      child: Text("Children", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),)
                                  )
                                ],
                              ),
                            ),
                            SizedBox(width: 10,),
                            InkWell(
                              splashColor: Colors.grey,
                              onTap: () {
                                Get.to(()=> ChoosePlanScreen());
                              },
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey
                                ),
                                child: const Center(
                                  child: Icon(Icons.add, color: Colors.blue, size: 32,),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 20,),
                        //const Center(child: Text("Choose a plan", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E2432)),)),
                        SizedBox(height: 20,),
                        const Text("Featured Plans", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E2432)),),
                        SingleChildScrollView(
                          child: Container(
                            height: 120,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Get.to(() => const StartPlanScreen(), arguments: [index[0], images[0], planNames[0]]);
                                  },
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.grey,
                                            image: const DecorationImage(
                                                image: AssetImage("images/child(36).jpg"),
                                                fit: BoxFit.cover
                                            )
                                        ),
                                      ),
                                      const Positioned(
                                          bottom: 0,
                                          child: Text("Children", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),)
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10,),
                                GestureDetector(
                                  onTap: (){
                                    Get.to(()=> const StartPlanScreen(), arguments: [index[1], images[1], planNames[1]]);
                                  },
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.grey,
                                            image: const DecorationImage(
                                                image: AssetImage("images/ben-white.jpg"),
                                                fit: BoxFit.cover
                                            )
                                        ),
                                      ),
                                      const Positioned(
                                          bottom: 0,
                                          child: Text("Marriage", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),)
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10,),
                                GestureDetector(
                                  onTap: (){
                                    Get.to(()=> const StartPlanScreen(), arguments: [index[2], images[2], planNames[2]]);
                                  },
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.grey,
                                            image: const DecorationImage(
                                                image: AssetImage("images/sean-pollock.jpg"),
                                                fit: BoxFit.cover
                                            )
                                        ),
                                      ),
                                      const Positioned(
                                          bottom: 0,
                                          child: Text("Business", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),)
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10,),
                                GestureDetector(
                                  onTap: (){
                                    Get.to(()=> const StartPlanScreen(), arguments: [index[3], images[3], planNames[3]]);
                                  },
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.grey,
                                            image: const DecorationImage(
                                                image: AssetImage("images/alex-kotliarskyi.jpg"),
                                                fit: BoxFit.cover
                                            )
                                        ),
                                      ),
                                      const Positioned(
                                          bottom: 0,
                                          child: Text("Work", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),)
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(width: 10,),
                                GestureDetector(
                                  onTap: (){
                                    Get.to(()=> const StartPlanScreen(), arguments: [index[4], images[4], planNames[4]]);
                                  },
                                  child: Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        height: 100,
                                        width: 100,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.grey,
                                            image: const DecorationImage(
                                                image: AssetImage("images/ibrahim-boran.jpg"),
                                                fit: BoxFit.cover
                                            )
                                        ),
                                      ),
                                      const Positioned(
                                          bottom: 0,
                                          child: Text("Finance", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),)
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                InkWell(
                  onTap: () {
                    _openTimePicker(context);
                  },
                  child: Container(
                    height: 370,
                    width: size.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: Colors.white
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 40, right: 20),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Reminders", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFF1E2432)),),
                              IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz_outlined, color: Colors.grey,))
                            ],
                          ),
                          SizedBox(height: 20,),
                          Container(
                            height: 200,
                            width: 300,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
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
                                        height: 150,
                                        width: 90,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
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
                                    height: 150,
                                    width: 90,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        const Text("Daily Prayer Reminder",
                                          style:
                                          TextStyle(fontSize: 12, fontWeight: FontWeight.w300, color: Colors.black54),
                                        ),
                                        SizedBox(height: 20,),
                                        const Text("Start talking to God",
                                          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 12, color: Color(0xFF1E2432)),
                                        ),
                                        SizedBox(height: 20,),
                                        Container(
                                          height: 40,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(40),
                                            color: Colors.grey
                                          ),
                                          child: const Center(
                                            child: Text("Pray Now", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E2432)),),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              )
                            ),
                          ),
                          SizedBox(height: 20,),

                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                //social media
                Container(
                  height: 220,
                  width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: _randomColor
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Container(
                                height: 150,
                                width: 90,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                )
                            ),
                            const Positioned(
                              bottom: 50,
                              child: Icon(Icons.follow_the_signs_sharp, color: Colors.grey, size: 18,),
                            )
                          ],
                        ),
                        Container(
                          width: 150,
                          height: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Want to know more about us", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),),
                              SizedBox(height: 20,),
                              const Text("Follow us on all our socials", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white)),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: AssetImage(
                                          "images/facebook-social.png"
                                        ),
                                        fit: BoxFit.fill
                                      )
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
      height: 100,
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
      padding: const EdgeInsets.only(left: 24, right: 24, top: 46),
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
                    height: 30,
                    width: 30,
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
                    height: 30,
                    width: 30,
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
                  height: 30,
                  width: 30,
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
  Size get preferredSize => const Size.fromHeight(126);
}
