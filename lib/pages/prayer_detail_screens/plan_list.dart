import 'package:flutter/material.dart';
import 'package:prophetic_prayers/pages/prayer_detail_screens/prayer_detail_screen.dart';

import '../../base/custom_loader.dart';
import '../../controller/scripture_controllers/scripture_controller.dart';
import '../../models/prayers.dart';
import '../../utils/dimensions.dart';
import 'package:get/get.dart';

class PlanListScreen extends StatefulWidget {
  const PlanListScreen({Key? key}) : super(key: key);

  @override
  State<PlanListScreen> createState() => _PlanListScreenState();
}

class _PlanListScreenState extends State<PlanListScreen> {

  @override
  void initState(){
    super.initState();
    ScriptureController.instance.readJson();
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
                  IconButton(onPressed: (){Get.back();}, icon: Icon(Icons.arrow_back, size: Dimensions.Width18, color: const Color(0xFF000000),)),
                  SizedBox(width: Dimensions.Width20,),
                  Text("Prayers For the Year", style: TextStyle(fontSize: Dimensions.Width16, fontWeight: FontWeight.bold, color: const Color(0xFF1E2432)),),
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
                height: double.maxFinite,
                margin: EdgeInsets.only(left: Dimensions.Width20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        height: Dimensions.Height500+233,
                        width: Dimensions.Width335,
                        child: FutureBuilder(
                            future: ScriptureController.instance.readJson(),
                            builder: (context, snapshot) {
                              if(snapshot.hasError) {
                                return Center(child: Text("${snapshot.error}"));
                              } else if(snapshot.hasData){

                                var _scriptures = snapshot.data as List<Scripture>;

                                return buildScriptures(_scriptures);
                              } else {
                                return const Center(child: CustomLoader(),);
                              }
                            }
                        )
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
    Widget buildScriptures(List<Scripture> scriptures) {
      return mounted ? ListView.builder(
        shrinkWrap: true,
        itemCount: scriptures.length,
        itemBuilder: (_, index) {
          final scriptureList = scriptures;
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
                      "Children"
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
                            color: const Color(0xffF7F8FA),
                        ),
                        child: Center(
                            child: Text(scriptureList[index].verse.toString()[0].toUpperCase(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24, color: Colors.black))
                        ),
                      ),
                      Expanded(
                          child: SizedBox(
                            height: 80,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(scriptureList[index].prayerPoint.toString(),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,),
                                  SizedBox(height: Dimensions.Height2+1,),
                                  Text(scriptureList[index].title.toString()),
                                  SizedBox(height: Dimensions.Height2+1,),
                                  Text(scriptureList[index].date.toString()),
                                  SizedBox(height: Dimensions.Height2+1,),
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
                SizedBox(height: Dimensions.Height20,),
              ]);
        },
      ): const Center(child: CustomLoader());
    }
}