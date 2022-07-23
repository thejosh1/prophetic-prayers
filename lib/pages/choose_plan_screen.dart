import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../utils/dimensions.dart';

class ChoosePlanScreen extends StatelessWidget {
  const ChoosePlanScreen({Key? key}) : super(key: key);

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
                children: [
                  IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back, size: Dimensions.prayerListScreenContainerWidth18, color: Color(0xFF000000),)),
                  SizedBox(width: 20,),
                  Text("Choose a Plan", style: TextStyle(fontSize: Dimensions.prayerListScreenContainerWidth16, fontWeight: FontWeight.bold, color: Color(0xFF1E2432)),),
                  //   IconButton(onPressed: (){}, icon: Icon(Icons.more_vert, size: 20, color: Color(0xFF000000),))
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 165,
                            width: 165,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              image: const DecorationImage(
                                image: AssetImage("images/child(36).jpg"),
                                fit: BoxFit.cover
                              )
                            ),
                          ),
                          SizedBox(height: 13,),
                          const Text("Children", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),)
                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 165,
                            width: 165,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: const DecorationImage(
                                    image: AssetImage("images/ben-white.jpg"),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          SizedBox(height: 13,),
                          const Text("Marriage", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 165,
                            width: 165,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: const DecorationImage(
                                    image: AssetImage("images/sean-pollock.jpg"),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          SizedBox(height: 13,),
                          const Text("Business", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),)
                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 165,
                            width: 165,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: const DecorationImage(
                                    image: AssetImage("images/alex-kotliarskyi.jpg"),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          SizedBox(height: 13,),
                          const Text("Work", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),)
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 165,
                            width: 165,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: const DecorationImage(
                                    image: AssetImage("images/ibrahim-boran.jpg"),
                                    fit: BoxFit.cover
                                )
                            ),
                          ),
                          SizedBox(height: 13,),
                          const Text("Finance", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),)
                        ],
                      ),
                      SizedBox(width: 10,),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
