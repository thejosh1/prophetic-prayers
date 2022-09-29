import 'package:flutter/material.dart';
import 'package:prophetic_prayers/controller/scripture_controller.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/prayer_detail_screens/prayer_detail_screen.dart';
import 'package:prophetic_prayers/utils/dimensions.dart';
import '../../models/prayers.dart';
import '../../services/route_services.dart';

class PrayerListScreen extends StatefulWidget {
  const PrayerListScreen({Key? key}) : super(key: key);

  @override
  State<PrayerListScreen> createState() => _PrayerListScreenState();
}

class _PrayerListScreenState extends State<PrayerListScreen> {

  @override
  void iniState(){
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
                     IconButton(onPressed: (){Get.back();},
                         icon: Icon(Icons.arrow_back,
                           size: Dimensions.Width18,
                           color: Color(0xFF000000),
                         )
                     ),
                     SizedBox(width: 20,),
                     Text("Prayers For the Year",
                       style: TextStyle(
                           fontSize: Dimensions.Width16,
                           fontWeight: FontWeight.bold, color: const Color(0xFF1E2432)
                       ),
                     ),
                   ],
                 ),
               ),
               Divider(
                 height: Dimensions.Height2,
                 color: Color(0xFFEAECEF),
                 thickness: Dimensions.Width2,
               ),
               Container(
                   margin: EdgeInsets.only(left: Dimensions.Width20),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Container(
                         height: Dimensions.Height632,
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
                               return const Center(child: Text("Loading"),);
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
    List data = Get.arguments;
    return mounted ? ListView.builder(
      shrinkWrap: true,
      itemCount: scriptures
          .where((e) => e.date?.split(" ")[0] == data[0])
          .length,
      itemBuilder: (_, index) {
        final scriptureList = scriptures.where((e) => e.date?.split(" ")[0] == data[0]).toList();
        return Column(
            children: [
              InkWell(
                splashColor: Colors.grey,
                onTap: (){
                  Get.toNamed(RouteServices.PRAYERDETAIL, arguments: [
                    scriptureList[index].id,
                    scriptureList[index].prayerPoint,
                    scriptureList[index].title,
                    scriptureList[index].verse,
                    scriptureList[index].date,
                    data[2]
                  ]);
                },
                child: Row(
                  children: [
                    Container(
                      height: Dimensions.Height60+20,
                      width: Dimensions.Width90-10,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.Width20),
                          border: Border.all(color: Colors.grey, width: Dimensions.Width2),
                          color: data[1]
                      ),
                      child: Center(
                          child: Text(scriptureList[index].verse.toString()[0].toUpperCase(),
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: Dimensions.Width28-4, color: Colors.white))
                      ),
                    ),
                    Expanded(
                        child: Container(
                          height: Dimensions.Height60+20,
                          child: Padding(
                            padding: EdgeInsets.only(left: Dimensions.Width10),
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
              //   GestureDetector(
              //   onTap: (){
              //     Get.to(()=> const PrayerDetailScreen(), arguments: [
              //       _selectedImage,
              //       scriptureList.title,
              //       scriptureList.prayerPoint,
              //       scriptureList.id,
              //       scriptureList.verse]);
              //   },
              //   child: Column(
              //     children: [
              //       Row(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           Container(
              //             height: Dimensions.prayerListScreenContainerHeight110,
              //             width: Dimensions.prayerListScreenContainerWidth90,
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(Dimensions.pageScreenExpandedRadiusHeight10),
              //               image: DecorationImage(
              //                   image: AssetImage(images[Random().nextInt(images.length)]),
              //                   fit: BoxFit.cover
              //               ),
              //             ),
              //           ),
              //           SizedBox(width: Dimensions.prayerListScreenContainerWidth15,),
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Container(
              //                   width: Dimensions.prayerListScreenContainerWidth150,
              //                   child: Text(scriptureList.title.toString(), style: TextStyle(color: Color(0xFF000000), fontSize: Dimensions.prayerListScreenContainerWidth16, fontWeight: FontWeight.bold),)
              //               ),
              //               SizedBox(height: Dimensions.prayerListScreenContainerHeight13,),
              //               Row(
              //                 children: [
              //                   Icon(Icons.star, color: Colors.amberAccent, size: Dimensions.prayerListScreenContainerWidth13,),
              //                   SizedBox(width: Dimensions.prayerListScreenContainerWidth6,),
              //                   Text(scriptureList.date.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.prayerListScreenContainerWidth14, color: Color(0xFFBEC2CE)),),
              //                   SizedBox(width: Dimensions.prayerListScreenContainerWidth6,),
              //                   Text("|", style: TextStyle(fontWeight: FontWeight.w200, fontSize: Dimensions.prayerListScreenContainerWidth14, color: Color(0xFFBEC2CE)),),
              //                   SizedBox(width: Dimensions.prayerListScreenContainerWidth6,),
              //                   //Text("24 reviews", style: TextStyle(fontWeight: FontWeight.w200, fontSize: 14, color: Color(0xFFBEC2CE)),),
              //                 ],
              //               ),
              //               SizedBox(height: Dimensions.prayerListScreenContainerHeight11,),
              //               SizedBox(
              //                 width: Dimensions.prayerListScreenContainerWidth170,
              //                 child: Row(
              //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                   children: [
              //                     Expanded(child: Container()),
              //                     Icon(Icons.bookmark_border_outlined, size: Dimensions.prayerListScreenContainerWidth19, color: Color(0xFFBEC2CE),)
              //                   ],
              //                 ),
              //               )
              //             ],
              //           )
              //         ],
              //       ),
              //       SizedBox(height: Dimensions.prayerListScreenContainerHeight18,),
              //       Divider()
              //     ],
              //   ),
              // );
            ]);
      },
    ): Container(child: Center(child: Text("nothing here"),),);
  }
}






