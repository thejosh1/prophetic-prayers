import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:prophetic_prayers/models/blessing.dart';
import 'package:prophetic_prayers/models/career.dart';
import 'package:prophetic_prayers/models/discipline.dart';
import 'package:prophetic_prayers/models/health.dart';
import 'package:prophetic_prayers/models/lifestyle.dart';
import 'package:prophetic_prayers/models/prosperity.dart';
import 'package:prophetic_prayers/models/warfare.dart';
import 'package:prophetic_prayers/pages/start_plan_screen.dart';
import 'package:prophetic_prayers/utils/shared_preferences.dart';
import '../controller/scripture_controller.dart';
import '../models/academy.dart';
import '../models/calling.dart';
import '../models/marriage.dart';
import '../utils/dimensions.dart';

class ChoosePlanScreen extends StatelessWidget {
  const ChoosePlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List planNames = ["Prosperity", "Academics", "Blessings", "Calling", "Career", "Discipline", "Health", "Lifestyle", "Marriage", "Warfare"];
    List models = [ProsperityScripture, Academy, Blessings, Calling, Career, Discipline, Health, LifeStyle, Marriage, Warfare];
    List index = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
    List images = ["images/child(36).jpg", "images/ben-white.jpg", "images/sean-pollock.jpg", "images/alex-kotliarskyi.jpg", "images/ibrahim-boran.jpg", "images/adrianna-geo.jpg", "images/diana-simum.jpg", "images/child(40).jpg", "images/child(41).jpg", "images/child(42).jpg"];
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
                        //crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () async{
                              Get.to(() => const StartPlanScreen(), arguments: [index[0], images[0], planNames[0], models[0]]);
                            },
                            child: Container(
                              height: 165,
                              width: 165,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: AssetImage(images[0]),
                                  fit: BoxFit.cover
                                )
                              ),
                            ),
                          ),
                          SizedBox(height: 13,),
                          Text(planNames[0], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black))
                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async{
                              Get.to(() => const StartPlanScreen(), arguments: [index[1], images[1], planNames[1], models[1]]);
                            },
                            child: Container(
                              height: 165,
                              width: 165,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                      image: AssetImage(images[1]),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 13,),
                          Text(planNames[1], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 30,),
                  Row(
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async{
                              Get.to(() => const StartPlanScreen(), arguments: [index[2], images[2], planNames[2], models[2]]);
                            },
                            child: Container(
                              height: 165,
                              width: 165,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                      image: AssetImage(images[2]),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 13,),
                          Text(planNames[2], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),)
                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async{
                              Get.to(() => const StartPlanScreen(), arguments: [index[3], images[3], planNames[3], models[3]]);
                            },
                            child: Container(
                              height: 165,
                              width: 165,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                      image: AssetImage(images[3]),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 13,),
                          Text(planNames[3], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),)
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async{
                              Get.to(() => const StartPlanScreen(), arguments: [index[4], images[4], planNames[4], models[4]]);
                            },
                            child: Container(
                              height: 165,
                              width: 165,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                      image: AssetImage(images[4]),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 13,),
                          Text(planNames[4], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),)
                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async{
                              Get.to(() => const StartPlanScreen(), arguments: [index[5], images[5], planNames[5], models[5]]);
                            },
                            child: Container(
                              height: 165,
                              width: 165,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                      image: AssetImage(images[5]),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 13,),
                          Text(planNames[5], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async{
                              Get.to(() => const StartPlanScreen(), arguments: [index[6], images[6], planNames[6], models[6]]);
                            },
                            child: Container(
                              height: 165,
                              width: 165,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                      image: AssetImage(images[6]),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 13,),
                          Text(planNames[6], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),)
                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async{
                              Get.to(() => const StartPlanScreen(), arguments: [index[7], images[7], planNames[7], models[7]]);
                            },
                            child: Container(
                              height: 165,
                              width: 165,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                      image: AssetImage(images[7]),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 13,),
                          Text(planNames[7], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),)
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async{
                              Get.to(() => const StartPlanScreen(), arguments: [index[8], images[8], planNames[8], models[8]]);
                            },
                            child: Container(
                              height: 165,
                              width: 165,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                      image: AssetImage(images[8]),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 13,),
                          Text(planNames[8], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),)
                        ],
                      ),
                      SizedBox(width: 10,),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () async{
                              Get.to(() => const StartPlanScreen(), arguments: [index[9], images[9], planNames[9], models[9]]);
                            },
                            child: Container(
                              height: 165,
                              width: 165,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                      image: AssetImage(images[9]),
                                      fit: BoxFit.cover
                                  )
                              ),
                            ),
                          ),
                          SizedBox(height: 13,),
                          Text(planNames[9], style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),)
                        ],
                      ),
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
