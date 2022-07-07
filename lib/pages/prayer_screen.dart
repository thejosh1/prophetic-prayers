import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prophetic_prayers/controller/scripture_controller.dart';
import 'package:prophetic_prayers/pages/prayer_list.dart';
import 'package:prophetic_prayers/pages/prayer_list_screen.dart';
import 'package:prophetic_prayers/pages/welcome.dart';
import 'package:prophetic_prayers/services/search_services.dart';
import 'package:prophetic_prayers/utils/dimensions.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';
import '../models/prayers.dart';
import '../widgets/big_text.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({Key? key}) : super(key: key);

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  Scripture scripture = Scripture();
  String selectedScriptures = '';

  @override
  void initState() {
    super.initState();
    readJson();
  }



  @override
  Widget build(BuildContext context) {
    final user = AuthController.instance.auth.currentUser;
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("users").doc(user!.uid).get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(),);
        } else if( snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!.exists) {
          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
          return Scaffold(
              body: SingleChildScrollView(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: Dimensions.pageScreenMainContainerWidth13, right: Dimensions.pageScreenMainContainerWidth13, top: Dimensions.pageScreenMainContainerHeight46),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      width: double.infinity,
                                      height: Dimensions.pageScreenExpandedContainerHeight40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.pageScreenExpandedRadiusHeight10),
                                        color: const Color(0xFFEDEEF0),
                                      ),
                                      padding: EdgeInsets.only(
                                          left: Dimensions.pageScreenExpandedPaddingWidth20, right: Dimensions.pageScreenExpandedPaddingWidth12, top: Dimensions.pageScreenExpandedPaddingHeight10),
                                      child: InkWell(
                                        onTap: () async{
                                          await showSearch(context: context, delegate: SearchServices(scripture));
                                        },
                                        child:  Row(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                                child: Text("search", style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: Dimensions.prayerListScreenContainerWidth14,
                                                    color: Color(0xFFBEC2CE)
                                                ))
                                            ),
                                            Icon(
                                              Icons.search_outlined,
                                              color: Colors.grey,
                                            ),
                                          ],
                                        ),
                                      )

                                  ),
                                ),
                                SizedBox(width: Dimensions.pageScreenSizedBoxWidth17),
                                CircleAvatar(
//Logo should be here
                                    backgroundImage: NetworkImage("${data["imagePath"]}")),
                              ],
                            ),
                            SizedBox(height: Dimensions.pageScreenSizedBoxHeight12),
                            BigText(text: "Welcome ${data["name"]}"),
                            SizedBox(height: Dimensions.pageScreenSizedBoxHeight16),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const PrayerListScreen());
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget> [
                                  Text("see all", style: TextStyle(fontSize: Dimensions.pageScreenSizedBoxHeight16, color: Colors.blue, fontWeight: FontWeight.w200),),
                                  Icon(Icons.arrow_forward_sharp, color: Colors.blue, size: Dimensions.pageScreenSizedBoxHeight16,)
                                ],
                              ),
                            ),
                            SizedBox(height: Dimensions.pageScreenExpandedRadiusHeight10),
                          ],
                        ),
                      ),
                      const WelcomeScreen(),
                    ],
                  ),
                ),
              )
          );
        }
        return Scaffold(
          body: SingleChildScrollView(
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: Dimensions.pageScreenMainContainerWidth13, right: Dimensions.pageScreenMainContainerWidth13, top: Dimensions.pageScreenMainContainerHeight46),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                  width: double.infinity,
                                  height: Dimensions.pageScreenExpandedContainerHeight40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.pageScreenExpandedRadiusHeight10),
                                    color: const Color(0xFFEDEEF0),
                                  ),
                                  padding: EdgeInsets.only(
                                      left: Dimensions.pageScreenExpandedPaddingWidth20, right: Dimensions.pageScreenExpandedPaddingWidth12, top: Dimensions.pageScreenExpandedPaddingHeight10),
                                  child: InkWell(
                                    onTap: () async{
                                      await showSearch(context: context, delegate: SearchServices(scripture));
                                    },
                                    child:  Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Text("search", style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: Dimensions.prayerListScreenContainerWidth14,
                                                color: const Color(0xFFBEC2CE)
                                            ))
                                        ),
                                        const Icon(
                                          Icons.search_outlined,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  )

                              ),
                            ),
                            SizedBox(width: Dimensions.pageScreenSizedBoxWidth17),
                            const CircleAvatar(
//Logo should be here
                                backgroundImage: AssetImage("gracious-adebayo.jpg")),
                          ],
                        ),
                        SizedBox(height: Dimensions.pageScreenSizedBoxHeight12),
                        const BigText(text: "Welcome"),
                        SizedBox(height: Dimensions.pageScreenSizedBoxHeight16),
                        GestureDetector(
                          onTap: () {
                            Get.to(() => const PrayerListScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget> [
                              Text("see all", style: TextStyle(fontSize: Dimensions.pageScreenSizedBoxHeight16, color: Colors.blue, fontWeight: FontWeight.w200),),
                              Icon(Icons.arrow_forward_sharp, color: Colors.blue, size: Dimensions.pageScreenSizedBoxHeight16,)
                            ],
                          ),
                        ),
                        SizedBox(height: Dimensions.pageScreenExpandedRadiusHeight10),
                      ],
                    ),
                  ),
                  const WelcomeScreen(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

