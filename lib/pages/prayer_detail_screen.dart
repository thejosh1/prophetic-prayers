import "package:flutter/material.dart";

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prophetic_prayers/pages/create_testimony_screen.dart';
import 'package:prophetic_prayers/utils/dimensions.dart';



import '../services/notify_services.dart';


class PrayerDetailScreen extends StatefulWidget {
  final String? payload;
  const PrayerDetailScreen({Key? key, this.payload}) : super(key: key);

  @override
  State<PrayerDetailScreen> createState() => _PrayerDetailScreenState();
}

class _PrayerDetailScreenState extends State<PrayerDetailScreen> {
  var data = Get.arguments;
  @override
  void initState() {
    super.initState();
    NotifyServices.init(initScheduled: true);
    listenNotifications();
    data;
  }

  void listenNotifications() =>
      NotifyServices.onNotifications.stream.listen(onClickedNotification);
  void onClickedNotification(String? payload) => Get.to(() => const PrayerDetailScreen(), arguments: [payload]);

  @override
  Widget build(BuildContext context) {
    final localizations = MaterialLocalizations.of(context);
    String currname = data[5].toString();
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
        print(_time);
        setState(() {
          NotifyServices.showNotification(
            title: "Prayer reminder",
            body: "Your reminder has been set to ${localizations.formatTimeOfDay(time)}",
            payload: data[2]
          );
        });
        int formattedtime = int.parse(_time.split(":")[0]);
        print(formattedtime);
        setState(() {
          NotifyServices.showScheduledNotification(
            title: "It's time to pray",
            body: data[2],
            payload: data[2],
            //to implement this subtract the time the user chooses from the current time and pass it as a duration in datetime.add
            scheduledDate: DateTime(int.parse(_time)),
          );
        });
      }
    }
    return Scaffold(
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        child: Stack(
          children: [
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  height: 440,
                  width: double.maxFinite,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/ibrahim-boran.jpg"),
                          fit: BoxFit.cover)),
                )
            ),
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.only(left: Dimensions.Width20, top: Dimensions.Height60, right: Dimensions.Width20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      // Icon(
                      //   Icons.more_vert,
                      //   color: Colors.white,
                      // )
                    ],
                  ),
                )),
            Positioned(
                top: Dimensions.Height270,
                child: Container(
                  padding: EdgeInsets.only(left: Dimensions.Width20+2, right: Dimensions.Width20, top: Dimensions.Height20),
                  width: MediaQuery.of(context).size.width,
                  height: Dimensions.Height500,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.Height20),
                          topRight: Radius.circular(Dimensions.Height20)),
                      color: Colors.white),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Color(0xFFBEC2CE),
                                  size: Dimensions.Width15,
                                ),
                                SizedBox(width: Dimensions.Width6-1,),
                                Text(
                                  //prayer id
                                  data[0],
                                  style: TextStyle(
                                      fontSize: Dimensions.Width14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFBEC2CE)),
                                )
                              ],
                            ),
                            Icon(
                              Icons.bookmark,
                              color: Color(0xFF1E2432),
                              size: Dimensions.Width19,
                            )
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.Height7,
                        ),
                        Text(data[5], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
                        Text(
                          //title
                          data[2],
                          style: TextStyle(
                              color: Color(0xFF1E2432),
                              fontSize: Dimensions.Width28,
                              fontWeight: FontWeight.w900),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: Dimensions.Height10*2),
                        // Row(
                        //   children: [
                        //     Icon(Icons.bolt, color: Colors.amberAccent, size: Dimensions.prayerListScreenContainerWidth18,),
                        //     SizedBox(width: Dimensions.prayerListStackPositionedContainerWidth3,),
                        //     Text("streak 2", style: TextStyle(color: Color(0xFF1E2432), fontSize: Dimensions.prayerListScreenContainerWidth18, fontWeight: FontWeight.bold),),
                        //     SizedBox(width: Dimensions.prayerListScreenContainerWidth6,),
                        //     Icon(Icons.sunny, size: Dimensions.prayerListScreenContainerWidth18, color: Colors.amberAccent,),
                        //     SizedBox(width: Dimensions.prayerListScreenContainerWidth6-3,),
                        //     Text("weeks 32", style: TextStyle(color: Color(0xFF1E2432), fontSize: Dimensions.prayerListScreenContainerWidth18, fontWeight: FontWeight.bold),)
                        //   ],
                        // ),
                        SizedBox(
                          height: Dimensions.Height18,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: (){
                                    _openTimePicker(context);
                                  },
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.notifications,
                                        size: Dimensions.Height29,
                                        color: Color(0xFFD1D1D6),
                                      ),
                                      SizedBox(
                                        height: Dimensions.Height8,
                                      ),
                                      Text(
                                        "Reminders",
                                        style:TextStyle(
                                            fontSize: Dimensions.Width14,
                                            fontWeight: FontWeight.w200,
                                            color: Color(0xFF1E2432)),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: Dimensions.Width6+2,
                            ),
                            GestureDetector(
                              onTap: (() {
                                Get.to(()=> const CreateTestimonyScreen(), arguments: [
                                 currname
                                ]);
                              }),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Icon(
                                        Icons.edit,
                                        size: Dimensions.Height29,
                                        color: Color(0xFFD1D1D6),
                                      ),
                                      SizedBox(
                                        height: Dimensions.Height8,
                                      ),
                                      Text(
                                        "Testify",
                                        style:TextStyle(
                                            fontSize: Dimensions.Width14,
                                            fontWeight: FontWeight.w200,
                                            color: Color(0xFF1E2432)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: Dimensions.Width6+2,
                            ),
                            Column(
                              children: [
                                Icon(
                                  Icons.list,
                                  size: Dimensions.Height29,
                                  color: Color(0xFFD1D1D6),
                                ),
                                SizedBox(
                                  height: Dimensions.Height8,
                                ),
                                Text(
                                  "prayers",
                                  style: TextStyle(
                                      fontSize: Dimensions.Width14,
                                      fontWeight: FontWeight.w200,
                                      color: Color(0xFF1E2432)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: Dimensions.pageScreenSizedBoxHeight12,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Dimensions.Height10*2,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Verse", style: TextStyle(color: Color(0xFF1E2432), fontSize: Dimensions.Width18, fontWeight: FontWeight.bold),),
                                Text(
                                  //scripture verse
                                  data[3],
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: Dimensions.Width16,
                                      fontWeight: FontWeight.w200,
                                      color: Color(0xFF1E2432)
                                  ),
                                ),
                                SizedBox(height: Dimensions.Height10*2,),
                                Text("Prayer Point", style: TextStyle(color: Color(0xFF1E2432), fontSize: Dimensions.Width18, fontWeight: FontWeight.bold),),
                                Text(
                                  //prayer point
                                  data[1],
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: Dimensions.Width16,
                                      fontWeight: FontWeight.w200,
                                      color: Color(0xFF1E2432)
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: Dimensions.Height10,),
                      ],
                    ),
                  ),
                )
            )
          ],
        ),
      ),
    );
  }

}
