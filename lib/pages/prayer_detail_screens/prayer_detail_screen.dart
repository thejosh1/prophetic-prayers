import 'dart:io';

import "package:flutter/material.dart";
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prophetic_prayers/utils/dimensions.dart';
import 'package:share_plus/share_plus.dart';

import '../../services/notify_services.dart';
import '../../services/route_services.dart';


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
  void onClickedNotification(String? payload) => Get.toNamed(RouteServices.PRAYERDETAIL, arguments: [payload]);

  @override
  Widget build(BuildContext context) {
    String currname = data[5].toString();
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: Dimensions.Height40*2,
            title: Container(
              margin: EdgeInsets.only(left: Dimensions.Width10, right: Dimensions.Width10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(Icons.arrow_back_ios, color: Colors.black,),
                  ),
                ],
              ),
            ),
            pinned: true,
            backgroundColor: Colors.white,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(Dimensions.Height20),
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.only(top: Dimensions.Height7-2, bottom: Dimensions.Height10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(Dimensions.Width20), topLeft: Radius.circular(Dimensions.Width20))
                ),
                child: Center(child: Text("Prophetic Prayers For Children", style: TextStyle(fontSize: Dimensions.Width10+8, fontWeight: FontWeight.bold),)),
              ),
            ),
            expandedHeight: Dimensions.Height100*3,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset("images/logo.jpeg",
                width: double.maxFinite,
                fit: BoxFit.contain,),
            )
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
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
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
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
                                    color: const Color(0xFFBEC2CE),
                                    size: Dimensions.Width15,
                                  ),
                                  SizedBox(width: Dimensions.Width6-1,),
                                  Text(
                                    //prayer id
                                    data[0],
                                    style: TextStyle(
                                        fontSize: Dimensions.Width14,
                                        fontWeight: FontWeight.bold,
                                        color: const Color(0xFFBEC2CE)),
                                  )
                                ],
                              ),
                              Text("${data[7]}" ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.Width15+1, color: const Color(0xFF1E2432)),)
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.Height7,
                          ),
                          Text("Prayers For Today", style: TextStyle(fontSize: Dimensions.Width16, fontWeight: FontWeight.w600),),
                          Text(
                            //title
                            data[1],
                            style: TextStyle(
                                color: const Color(0xFF1E2432),
                                fontSize: Dimensions.Width28,
                                fontWeight: FontWeight.w900),
                            textAlign: TextAlign.start,
                          ),
                          SizedBox(height: Dimensions.Height10*2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () async{
                                     ByteData imagebyte = await rootBundle.load("images/banner.jpeg");
                                     String urlLink = "https://propheticprayers.page.link/muUh";

                                      final temp = await getTemporaryDirectory();
                                      final path = '${temp.path}/banner.jpeg';
                                      File(path).writeAsBytesSync(imagebyte.buffer.asUint8List());
                                      await Share.shareFiles([path], text: "${data[1]}\n ${data[2]}}\n $urlLink",);
                                    },
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.share_outlined,
                                          size: Dimensions.Height29,
                                          color: const Color(0xFFD1D1D6),
                                        ),
                                        SizedBox(
                                          height: Dimensions.Height8,
                                        ),
                                        Text(
                                          "Share",
                                          style:TextStyle(
                                              fontSize: Dimensions.Width14,
                                              fontWeight: FontWeight.w200,
                                              color: const Color(0xFF1E2432)),
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
                                  Get.toNamed(RouteServices.CREATETESTIMONYSCREEN, arguments: [
                                    currname
                                  ]);
                                }),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Icon(
                                          Icons.edit_note,
                                          size: Dimensions.Height29,
                                          color: const Color(0xFFD1D1D6),
                                        ),
                                        SizedBox(
                                          height: Dimensions.Height8,
                                        ),
                                        Text(
                                          "Testify",
                                          style:TextStyle(
                                              fontSize: Dimensions.Width14,
                                              fontWeight: FontWeight.w200,
                                              color: const Color(0xFF1E2432)),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: Dimensions.Width6+2,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.toNamed(RouteServices.PLANLISTSCREEN);
                                },
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.list,
                                      size: Dimensions.Height29,
                                      color: const Color(0xFFD1D1D6),
                                    ),
                                    SizedBox(
                                      height: Dimensions.Height8,
                                    ),
                                    Text(
                                      "prayers",
                                      style: TextStyle(
                                          fontSize: Dimensions.Width14,
                                          fontWeight: FontWeight.w200,
                                          color: const Color(0xFF1E2432)),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: Dimensions.pageScreenSizedBoxHeight12,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: Dimensions.Height10*2,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Verse", style: TextStyle(color: const Color(0xFF1E2432), fontSize: Dimensions.Width18, fontWeight: FontWeight.bold),),
                              Text(
                                //scripture verse
                                data[2],
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: Dimensions.Width16,
                                    fontWeight: FontWeight.w200,
                                    color: const Color(0xFF1E2432)
                                ),
                              ),
                              SizedBox(height: Dimensions.Height10*2,),
                              //Text("Prayer Point", style: TextStyle(color: const Color(0xFF1E2432), fontSize: Dimensions.Width18, fontWeight: FontWeight.bold),),
                              Text(
                                //prayer point
                                data[3],
                                style: TextStyle(
                                    fontFamily: 'Poppins',
                                    fontSize: Dimensions.Width16,
                                    fontWeight: FontWeight.w200,
                                    color: const Color(0xFF1E2432)
                                ),
                              ),

                            ],
                          ),
                          SizedBox(height: Dimensions.Height20,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}
