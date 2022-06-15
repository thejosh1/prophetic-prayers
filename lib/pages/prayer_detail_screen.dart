import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:prophetic_prayers/pages/prayer_list_screen.dart';
import 'package:prophetic_prayers/pages/testimony_screen.dart';
import 'package:prophetic_prayers/widgets/my_input_field.dart';

class PrayerDetailScreen extends StatefulWidget {
  const PrayerDetailScreen({Key? key}) : super(key: key);

  @override
  State<PrayerDetailScreen> createState() => _PrayerDetailScreenState();
}

class _PrayerDetailScreenState extends State<PrayerDetailScreen> {
  DateTime _selectedDate = DateTime.now();
  String _startTime = DateFormat("hh:mm, a").format(DateTime.now()).toString();
  String _endTime = "10:30 am";
  @override
  Widget build(BuildContext context) {

    var data = Get.arguments;
    final int _checkedStars = 4;
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
                          image: AssetImage("images/diana-simum.jpg"),
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
                      Icon(
                        Icons.more_vert,
                        color: Colors.white,
                      )
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
                    width: 320,
                    // margin: EdgeInsets.only(left: 10),
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
                                  data[2],
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
                          data[0],
                          style: TextStyle(
                              color: Color(0xFF1E2432),
                              fontSize: 28,
                              fontWeight: FontWeight.w900),
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(height: 12),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: (){
                                    showModalBottomSheet(context: context, builder: (context) => _buildSheet());
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
                            GestureDetector(
                              onTap: (){
                                Get.to(()=>const TestimonyScreen());
                              },
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    children: [
                                      Stack(
                                        children: <Widget>[
                                          Icon(Icons.church, size: 29.89, color: Color(0xFFD1D1D6),),
                                          Positioned(
                                            right: 0,
                                            child: Container(
                                              padding: EdgeInsets.all(1),
                                              decoration: BoxDecoration(
                                                color: Color(0xFF1E2432),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              constraints: BoxConstraints(
                                                minWidth: 12,
                                                minHeight: 12,
                                              ),
                                              child: Text(
                                                '5',
                                                style: new TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 8,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width: 8.6,
                                      ),
                                      Text(
                                        "Testimonies",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w200,
                                            color: Color(0xFF1E2432)),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
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
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Verse", style: TextStyle(color: Color(0xFF1E2432), fontSize: 18, fontWeight: FontWeight.bold),),
                            Text(
                              data[3],
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
                              data[1],
                              style: TextStyle(
                                  fontFamily: 'Poppins',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w200,
                                  color: Color(0xFF1E2432)
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 10,),
                        // GestureDetector(
                        //   onTap: () {},
                        //   child: ClipRRect(
                        //     borderRadius: BorderRadius.circular(12),
                        //     child: Container(
                        //       width: double.infinity,
                        //       height: 50,
                        //       color: const Color(0xff515BDE),
                        //       alignment: Alignment.center,
                        //       child: const Text(
                        //         'BOOKS FROM \$845.00',
                        //         style: TextStyle(
                        //           color: Colors.white,
                        //           fontSize: 18,
                        //           fontWeight: FontWeight.w700,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildSheet() {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Set Timer", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
          SizedBox(height: 30,),
          Row(
            children: [
              Expanded(child: MyInputField(
                title: "Start Time",
                hint: _startTime,
                widget: IconButton(
                  onPressed: (){
                    _getUserTime(isStartTime: true);
                  },
                  icon: Icon(Icons.access_time_filled_outlined, color: Colors.grey,),
                ),
              )),
              SizedBox(width: 12,),
              Expanded(child: MyInputField(
                title: "end Time",
                hint: _endTime,
                widget: IconButton(
                  onPressed: (){
                    _getUserTime(isStartTime: false);
                  },
                  icon: Icon(Icons.access_time_filled_outlined, color: Colors.grey,),
                ),
              ))
            ],
          )
        ],
      ),
    );
  }

  _getUserTime({required bool isStartTime}) async {
    var pickedTime = await _showTimePicker();
    String formattedTime = pickedTime.format(context);
    if(pickedTime == null) {

    } else if(isStartTime == true) {
      _startTime = formattedTime;
    } else if(isStartTime == false) {
      _endTime = formattedTime;
    }
  }

  _showTimePicker(){
    return showTimePicker(
      initialEntryMode: TimePickerEntryMode.input,
        context: context,
        initialTime: TimeOfDay(
            hour: int.parse(_startTime.split(":")[0]),
            minute: int.parse(_startTime.split(":")[1].split(" ")[0])
        )
    );
  }
}
