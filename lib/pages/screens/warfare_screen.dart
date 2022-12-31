import 'package:flutter/material.dart';
import 'package:prophetic_prayers/controller/scripture_controllers/scripture_controller.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/models/warfare.dart';
import 'package:prophetic_prayers/services/route_services.dart';
import 'package:prophetic_prayers/utils/dimensions.dart';



class WarfareScreen extends StatefulWidget {
  const WarfareScreen({Key? key}) : super(key: key);

  @override
  State<WarfareScreen> createState() => _WarfareScreenState();
}

class _WarfareScreenState extends State<WarfareScreen> {

  @override
  void iniState(){
    super.initState();
    ScriptureController.instance.readWarfareJson();
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
                  SizedBox(width: 20),
                  Text("Prophetic Prayers For Warfare",
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
                              future: ScriptureController.instance.readWarfareJson(),
                              builder: (context, snapshot) {
                                if(snapshot.hasError) {
                                  return Center(child: Text("${snapshot.error}"));
                                } else if(snapshot.hasData){
                                  var _scriptures = snapshot.data as List<Warfare>;

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
  Widget buildScriptures(List<Warfare> scriptures) {
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
                    "Prayers for Warfare"
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
                          color: Colors.red
                        //color: data[1]
                      ),
                      child: Center(
                          child: Text(scriptureList[index].verse.toString()[0],
                              style:  TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: Dimensions.Width20+4, color: Colors.white))
                      ),
                    ),
                    Expanded(
                        child: Container(
                          height: Dimensions.Height60+20,
                          child: Padding(
                            padding:  EdgeInsets.only(left: Dimensions.Width10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(scriptureList[index].verse.toString(),
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
                                    List.generate(5, (index) => Icon(
                                      Icons.star, color: Colors.amberAccent,
                                      size: Dimensions.Width15,))
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
    ): const Center(child: Text("nothing here"),);
  }
}






