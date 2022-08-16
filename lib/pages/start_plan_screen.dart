import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/main_page.dart';
import 'package:prophetic_prayers/pages/welcome.dart';

import '../utils/shared_preferences.dart';

class StartPlanScreen extends StatefulWidget {
  const StartPlanScreen({Key? key}) : super(key: key);

  @override
  State<StartPlanScreen> createState() => _StartPlanScreenState();
}

class _StartPlanScreenState extends State<StartPlanScreen> {
  @override
  Widget build(BuildContext context) {
    List Listindex = [0, 1, 2, 3, 4,];
    var data = Get.arguments;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(data[1]),
                  fit: BoxFit.cover
                )
              ),
            ),
            Container(
              height: 50,
              width: size.width,
              child: Center(
                child: Text("Prophetic prayers for ${data[2]}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),),
              ),
            ),
            const Divider(),
            Container(
              margin: EdgeInsets.only( top: 20, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Grace upon Grace", style: TextStyle(fontSize: 16),),
                  ),
                  SizedBox(height: 10,),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("A 365 days prayer plan", style: TextStyle(fontSize: 16),),
                  ),
                  SizedBox(height: 20,),
                  GestureDetector(
                    onTap: () async{
                      await AppPreferences.setPrayerType(data[2].toString());
                      await AppPreferences.setImageType(data[2].toString());
                      await AppPreferences.setImageName(data[1]);
                      Get.to(()=> const WelcomeScreen());
                    },
                    child: Container(
                      height: 50,
                      width: 320,
                      margin: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: Colors.brown
                      ),
                      child: const Center(
                        child: Text("Start Plan", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: const Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, "
                            "sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. "
                            "Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. "
                            "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. "
                            "Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                      style: TextStyle(fontWeight: FontWeight.bold, height: 1.5),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text("Other Plans", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF1E2432)),),
                  ),
                  Divider(),
                  SingleChildScrollView(
                    child: Container(
                      height: 120,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                SizedBox(height: 20,),
                                Container(
                                  height: 120,
                                  width: 360,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      SizedBox(width: 20,),
                                      Listindex[0] == data[0] ? SizedBox():GestureDetector(
                                        onTap: () {
                                          Get.to(()=> const StartPlanScreen());
                                        },
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 120,
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
                                      Listindex[0] == data[0] ? SizedBox():SizedBox(width: 10,),
                                      Listindex[1] == data[0] ? SizedBox():GestureDetector(
                                        onTap: (){
                                          Get.to(()=> const StartPlanScreen());
                                        },
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 120,
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
                                      Listindex[1] == data[0] ? SizedBox():SizedBox(width: 10,),
                                      Listindex[2] == data[0] ? SizedBox():GestureDetector(
                                        onTap: (){
                                          Get.to(()=> const StartPlanScreen());
                                        },
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 120,
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
                                      Listindex[2] == data[0] ? SizedBox():SizedBox(width: 10,),
                                      Listindex[3] == data[0] ? SizedBox():GestureDetector(
                                        onTap: (){
                                          Get.to(()=> const StartPlanScreen());
                                        },
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 120,
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(10),
                                                  color: Colors.grey,
                                                  image: const DecorationImage(
                                                      image: AssetImage("images/alex-kotliarskyi.jpg"),
                                                      fit: BoxFit.cover
                                                  )
                                              ),
                                            ),
                                            Positioned(
                                                bottom: 0,
                                                child: Text("Work", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),)
                                            )
                                          ],
                                        ),
                                      ),
                                      Listindex[3] == data[0] ? SizedBox():SizedBox(width: 10,),
                                      Listindex[4] == data[0] ? SizedBox():GestureDetector(
                                        onTap: (){
                                          Get.to(()=> const StartPlanScreen());
                                        },
                                        child: Stack(
                                          alignment: Alignment.bottomCenter,
                                          children: [
                                            Container(
                                              height: 100,
                                              width: 120,
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
                              ],
                            );
                          }
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
