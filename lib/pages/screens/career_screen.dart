import 'package:flutter/material.dart';
import 'package:prophetic_prayers/controller/scripture_controller.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/prayer_detail_screen.dart';
import 'package:prophetic_prayers/utils/dimensions.dart';

import '../../models/career.dart';

class CareerScreen extends StatefulWidget {
  const CareerScreen({Key? key}) : super(key: key);

  @override
  State<CareerScreen> createState() => _CareerScreenState();
}

class _CareerScreenState extends State<CareerScreen> {

  @override
  void iniState(){
    super.initState();
    ScriptureController.instance.readCareerJson();
  }
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
                  IconButton(
                      onPressed: (){Get.back();},
                      icon: Icon(Icons.arrow_back,
                        size: Dimensions.prayerListScreenContainerWidth18,
                        color: const Color(0xFF000000),
                      )
                  ),
                  SizedBox(width: 20),
                  Text("Prophetic Prayers For Career",
                    style: TextStyle(
                        fontSize: Dimensions.prayerListScreenContainerWidth16,
                        fontWeight: FontWeight.bold, color: const Color(0xFF1E2432)
                    ),
                  ),
                  //   IconButton(onPressed: (){}, icon: Icon(Icons.more_vert, size: 20, color: Color(0xFF000000),))
                ],
              ),
            ),
            Divider(
              height: Dimensions.prayerListScreenContainerHeight2,
              color: const Color(0xFFEAECEF),
              thickness: Dimensions.prayerListScreenContainerWidth2,
            ),
            Container(
                margin: EdgeInsets.only(left: Dimensions.prayerListScreenContainerWidth20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      child: Container(
                          height: 632,
                          width: Dimensions.prayerListScreenContainerWidth335,
                          child: FutureBuilder(
                              future: ScriptureController.instance.readCareerJson(),
                              builder: (context, snapshot) {
                                if(snapshot.hasError) {
                                  return Center(child: Text("${snapshot.error}"));
                                } else if(snapshot.hasData){
                                  var _scriptures = snapshot.data as List<Career>;

                                  return buildScriptures(_scriptures);
                                } else {
                                  return Center(child: const Text("Loading"),);
                                }
                              }
                          )
                      ),
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );

  }
  Widget buildScriptures(List<Career> scriptures) {
    List data = Get.arguments;
    return mounted ? ListView.builder(
      shrinkWrap: true,
      itemCount: scriptures.length,
      itemBuilder: (_, index) {
        final scriptureList = scriptures.toList();
        return Column(
            children: [
              InkWell(
                splashColor: Colors.grey,
                onTap: (){
                  Get.to(()=> const PrayerDetailScreen(), arguments: [
                    scriptureList[index].id,
                    scriptureList[index].prayerPoint,
                    scriptureList[index].title,
                    scriptureList[index].verse,
                    scriptureList[index].date,
                    data[0]
                  ]);
                },
                child: Row(
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey, width: 2),
                          color: Colors.deepOrange
                        //color: data[1]
                      ),
                      child: Center(
                          child: Text(scriptureList[index].verse.toString()[0],
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white))
                      ),
                    ),
                    Expanded(
                        child: Container(
                          height: 80,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(scriptureList[index].verse.toString(),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,),
                                SizedBox(height: 3,),
                                Text(scriptureList[index].title.toString()),
                                SizedBox(height: 3,),
                                Text(scriptureList[index].date.toString()),
                                SizedBox(height: 3,),
                                Row(
                                  children: [
                                    Wrap(children:
                                    List.generate(5, (index) => const Icon(
                                      Icons.star, color: Colors.amberAccent,
                                      size: 15,))
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
              SizedBox(height: 20,),
            ]);
      },
    ): Container(child: Center(child: Text("nothing here"),),);
  }
}






