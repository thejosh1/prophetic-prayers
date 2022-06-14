import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/create_testimony_screen.dart';
import 'package:prophetic_prayers/pages/testimony_detail_page.dart';

class TestimonyScreen extends StatefulWidget {
  const TestimonyScreen({Key? key}) : super(key: key);

  @override
  State<TestimonyScreen> createState() => _TestimonyScreenState();
}

class _TestimonyScreenState extends State<TestimonyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(left: 10, right: 16.7, top: 44),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 18,
                          color: Color(0xFF000000),
                        )),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.more_vert,
                          size: 20,
                          color: Color(0xFF000000),
                        ))
                  ],
                ),
              ),
              Divider(
                height: 2,
                color: Color(0xFFEAECEF),
                thickness: 2,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              "TESTIMONIES",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF1E2432)),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Container(
                              height: 27,
                              width: 27,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xFFE2952A)),
                              child: Center(
                                child: Text(
                                    "4",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w800,
                                        color: Colors.white)
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: 154,
                          height: 28,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: Color(0xFF515BDE), width: 1.5),
                          ),
                          child: GestureDetector(
                            onTap: (){
                              Get.to(()=> const CreateTestimonyScreen());
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Icons.mail_outline_outlined,
                                  color: Color(0xFF515BDE),
                                ),
                                Text("Testify")
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 15,),
                    SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        children: <Widget>[
                          Container(
                            height:500,
                            width: 340,
                            margin: EdgeInsets.only(right: 16),
                            child: ListView.separated(
                              itemCount: 4,
                              itemBuilder: (_, index){
                                return _buildList(index);
                              }, separatorBuilder: (BuildContext context, int index) { return Divider(); },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Positioned(
                child: IgnorePointer(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.center,
                            end: Alignment.bottomCenter,
                            colors: [Colors.transparent, Colors.grey.withOpacity(0.1)]
                        )
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      )
    );
  }

  Widget _buildList(int index) {
    return GestureDetector(
      onTap: (){
        Get.to(()=> const TestimonyDetailPage());
      },
      child: Container(
        height: 158,
        width: 340,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("images/gracious-adebayo.jpg"),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Anonymous", style: TextStyle(
                      fontSize:16,
                      fontWeight: FontWeight.bold,)
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded, size: 16, color: Color(0xffBEC2CE),),
                        Text("2 hours Ago", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xffBEC2CE)),)
                      ],
                    ),
                    SizedBox(height: 4,),
                    Container(
                      height: 81,
                      width: 250,
                      child: Text("There are many variations of messages of lorem ipsum available, but the majority have suffered",
                      style: TextStyle(fontWeight: FontWeight.w200, fontSize: 16, color: Colors.black),),
                    ),
                  ]
                ),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                SizedBox(width: 11,),
                Row(
                  children: [
                    Icon(Icons.launch_rounded, size: 13.21, color: Color(0xffBEC2CE),),
                    Text("See More")
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
