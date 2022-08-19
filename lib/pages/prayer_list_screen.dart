import 'package:flutter/material.dart';
import 'package:prophetic_prayers/controller/scripture_controller.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/prayer_detail_screen.dart';
import 'package:prophetic_prayers/utils/dimensions.dart';
import '../models/prayers.dart';

class PrayerListScreen extends StatefulWidget {
  const PrayerListScreen({Key? key}) : super(key: key);

  @override
  State<PrayerListScreen> createState() => _PrayerListScreenState();
}

class _PrayerListScreenState extends State<PrayerListScreen> {

  @override
  void iniState(){
    super.initState();
    readJson();
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
                     IconButton(onPressed: (){Get.back();},
                         icon: Icon(Icons.arrow_back,
                           size: Dimensions.prayerListScreenContainerWidth18,
                           color: Color(0xFF000000),
                         )
                     ),
                     SizedBox(width: 20,),
                     Text("Prayers For the Year",
                       style: TextStyle(
                           fontSize: Dimensions.prayerListScreenContainerWidth16,
                           fontWeight: FontWeight.bold, color: const Color(0xFF1E2432)
                       ),
                     ),
                   ],
                 ),
               ),
               Divider(
                 height: Dimensions.prayerListScreenContainerHeight2,
                 color: Color(0xFFEAECEF),
                 thickness: Dimensions.prayerListScreenContainerWidth2,
               ),
               Container(
                   margin: EdgeInsets.only(left: Dimensions.prayerListScreenContainerWidth20),
                   child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                       Container(
                         height: Dimensions.prayerListScreenContainerHeight532,
                         width: Dimensions.prayerListScreenContainerWidth335,
                         child: FutureBuilder(
                           future: readJson(),
                           builder: (context, snapshot) {
                             if(snapshot.hasError) {
                               return Center(child: Text("${snapshot.error}"));
                             } else if(snapshot.hasData){

                               var _scriptures = snapshot.data as List<Scripture>;

                               return buildScriptures(_scriptures);
                             } else {
                               return Center(child: const Text("Loading"),);
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
                  Get.to(()=> const PrayerDetailScreen(), arguments: [
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
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: Colors.grey, width: 2),
                          color: data[1]
                      ),
                      child: Center(
                          child: Text(scriptureList[index].verse.toString()[0].toUpperCase(),
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






