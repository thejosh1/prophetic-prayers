import 'package:flutter/material.dart';
import 'package:prophetic_prayers/controller/scripture_controllers/scripture_controller.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/services/route_services.dart';
import 'package:prophetic_prayers/utils/dimensions.dart';

import '../../models/health.dart';
import '../prayer_detail_screens/prayer_detail_screen.dart';

class HealthScreen extends StatefulWidget {
  const HealthScreen({Key? key}) : super(key: key);

  @override
  State<HealthScreen> createState() => _HealthScreenState();
}

class _HealthScreenState extends State<HealthScreen> {

  @override
  void iniState(){
    super.initState();
    ScriptureController.instance.readHealthJson();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(left: Dimensions.Width10, right: Dimensions.Width16, top: Dimensions.Height44),
              child: Row(
                children: [
                  IconButton(
                      onPressed: (){Get.back();},
                      icon: Icon(Icons.arrow_back,
                        size: Dimensions.Width18,
                        color: const Color(0xFF000000),
                      )
                  ),
                  SizedBox(width: Dimensions.Height20),
                  Text("Prophetic Prayers For Health",
                    style: TextStyle(
                        fontSize: Dimensions.Width16,
                        fontWeight: FontWeight.bold, color: const Color(0xFF1E2432)
                    ),
                  ),
                  //   IconButton(onPressed: (){}, icon: Icon(Icons.more_vert, size: 20, color: Color(0xFF000000),))
                ],
              ),
            ),
            Divider(
              height: Dimensions.Height2,
              color: const Color(0xFFEAECEF),
              thickness: Dimensions.Width2,
            ),
            Container(
                margin: EdgeInsets.only(left: Dimensions.Width20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SingleChildScrollView(
                      child: Container(
                          height: Dimensions.Height632,
                          width: Dimensions.Width335,
                          child: FutureBuilder(
                              future: ScriptureController.instance.readHealthJson(),
                              builder: (context, snapshot) {
                                if(snapshot.hasError) {
                                  return Center(child: Text("${snapshot.error}"));
                                } else if(snapshot.hasData){
                                  var _scriptures = snapshot.data as List<Health>;

                                  return buildScriptures(_scriptures);
                                } else {
                                  return const Center(child: Text("Loading"),);
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
  Widget buildScriptures(List<Health> scriptures) {
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
                  Get.toNamed(RouteServices.OTHERDETAILSCREEN, arguments: [
                    scriptureList[index].id,
                    scriptureList[index].title,
                    scriptureList[index].verse,
                    scriptureList[index].date,
                    data[0],
                    data[1],
                    "Prayers for Health"
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
                          color: Colors.green
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






