import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PrayerDetailScreen extends StatefulWidget {
  const PrayerDetailScreen({Key? key}) : super(key: key);

  @override
  State<PrayerDetailScreen> createState() => _PrayerDetailScreenState();
}

class _PrayerDetailScreenState extends State<PrayerDetailScreen> {
  @override
  Widget build(BuildContext context) {
    Future<void> _openTimePicker(BuildContext context) async {
      final TimeOfDay? time = await showTimePicker(context: context, initialTime: TimeOfDay.now());
      if(time !=null) {
        //set a scheduled notification based on the time
      }
    }
    var data = Get.arguments;
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
                  height: 300,
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("images/" + data[0]),
                          fit: BoxFit.cover)),
                )),
            Positioned(
                left: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.only(left: 20, top: 60, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: (){
                          Get.back();
                        },
                        child: Icon(
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
                top: 270,
                child: Container(
                  padding: EdgeInsets.only(left: 22, right: 20, top: 20),
                  width: MediaQuery.of(context).size.width,
                  height: 500,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
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
                                  Icons.hourglass_bottom_outlined,
                                  color: Color(0xFFBEC2CE),
                                  size: 15,
                                ),
                                Text(
                                  data[3],
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFBEC2CE)),
                                )
                              ],
                            ),
                            Icon(
                              Icons.bookmark,
                              color: Color(0xFF1E2432),
                              size: 19.26,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        Text(
                          data[1],
                          style: TextStyle(
                              color: Color(0xFF1E2432),
                              fontSize: 28,
                              fontWeight: FontWeight.w900),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            Icon(Icons.bolt, color: Colors.amberAccent, size: 18,),
                            SizedBox(width: 3,),
                            Text("streak 2", style: TextStyle(color: Color(0xFF1E2432), fontSize: 18, fontWeight: FontWeight.bold),),
                            SizedBox(width: 6,),
                            Icon(Icons.sunny, size: 18, color: Colors.amberAccent,),
                            SizedBox(width: 3,),
                            Text("weeks 32", style: TextStyle(color: Color(0xFF1E2432), fontSize: 18, fontWeight: FontWeight.bold),)
                          ],
                        ),
                        SizedBox(
                          height: 18.3,
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
                                        size: 29.89,
                                        color: Color(0xFFD1D1D6),
                                      ),
                                      SizedBox(
                                        height: 8.6,
                                      ),
                                      Text(
                                        "Reminders",
                                        style:TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200,
                                            color: Color(0xFF1E2432)),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            // GestureDetector(
                            //   onTap: (){
                            //     Get.to(()=>const TestimonyScreen());
                            //   },
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     children: [
                            //       Column(
                            //         children: [
                            //           Stack(
                            //             children: <Widget>[
                            //               Icon(Icons.edit, size: 29.89, color: Color(0xFFD1D1D6),),
                            //               Positioned(
                            //                 right: 0,
                            //                 child: Container(
                            //                   padding: EdgeInsets.all(1),
                            //                   decoration: BoxDecoration(
                            //                     color: Color(0xFF1E2432),
                            //                     borderRadius: BorderRadius.circular(6),
                            //                   ),
                            //                   constraints: BoxConstraints(
                            //                     minWidth: 12,
                            //                     minHeight: 12,
                            //                   ),
                            //                   child: Text(
                            //                     '5',
                            //                     style: new TextStyle(
                            //                       color: Colors.white,
                            //                       fontSize: 8,
                            //                     ),
                            //                     textAlign: TextAlign.center,
                            //                   ),
                            //                 ),
                            //               )
                            //             ],
                            //           ),
                            //           SizedBox(
                            //             width: 8.6,
                            //           ),
                            //           Text(
                            //             "Testimonies",
                            //             style: TextStyle(
                            //                 fontSize: 14,
                            //                 fontWeight: FontWeight.w200,
                            //                 color: Color(0xFF1E2432)),
                            //           ),
                            //         ],
                            //       )
                            //     ],
                            //   ),
                            // ),
                            // SizedBox(
                            //   width: 8,
                            // ),
                            Column(
                              children: [
                                Icon(
                                  Icons.list,
                                  size: 29.89,
                                  color: Color(0xFFD1D1D6),
                                ),
                                SizedBox(
                                  width: 8.6,
                                ),
                                Text(
                                  "prayers",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w200,
                                      color: Color(0xFF1E2432)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 12,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Verse", style: TextStyle(color: Color(0xFF1E2432), fontSize: 18, fontWeight: FontWeight.bold),),
                                Text(
                                  data[4],
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w200,
                                      color: Color(0xFF1E2432)
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Text("Prayer Point", style: TextStyle(color: Color(0xFF1E2432), fontSize: 18, fontWeight: FontWeight.bold),),
                                Text(
                                  data[2],
                                  style: TextStyle(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w200,
                                      color: Color(0xFF1E2432)
                                  ),
                                ),

                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
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
