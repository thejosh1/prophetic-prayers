import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/testimony_detail_page.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/widgets/big_text.dart';

import '../controller/auth_controller.dart';
import '../models/prayers.dart';
import '../services/search_services.dart';
import '../services/testimony_services.dart';
import '../utils/dimensions.dart';

class DiscoverScreen extends StatefulWidget {
  const DiscoverScreen({Key? key}) : super(key: key);

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  Scripture scripture = Scripture();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 100,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                          blurRadius: 0.5,
                          spreadRadius: 0.5,
                          offset: Offset(0, 3),
                          color: Colors.transparent
                      )
                    ]
                ),
                padding: const EdgeInsets.only(left: 20, right: 24, top: 46),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    BigText(text: "Discover")
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 40,
                width: 340,
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
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
                                const Icon(
                                  Icons.search_outlined,
                                  color: Colors.grey,
                                ),
                                Expanded(
                                    child: Text("search", style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: Dimensions.prayerListScreenContainerWidth14,
                                        color: Color(0xFFBEC2CE)
                                    ))
                                ),

                              ],
                            ),
                          )

                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Container(
                  margin: EdgeInsets.only(left: 20),
                  child: const Text("Featured Plans", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 32, color: Color(0xFF1E2432)),)
              ),
              SizedBox(height: 20,),
              SingleChildScrollView(
                child: Container(
                  height: 220,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            SizedBox(width: 20,),
                            Container(
                              height: 220,
                              width:370,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        height: 220,
                                        width: 150,
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
                                  SizedBox(width: 10,),
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        height: 220,
                                        width: 150,
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
                                  SizedBox(width: 10,),
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        height: 220,
                                        width: 150,
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
                                  SizedBox(width: 10,),
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        height: 220,
                                        width: 150,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.grey,
                                            image: const DecorationImage(
                                                image: AssetImage("images/alex-kotliarskyi.jpg"),
                                                fit: BoxFit.cover
                                            )
                                        ),
                                      ),
                                      const Positioned(
                                          bottom: 0,
                                          child: Text("Work", style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),)
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 10,),
                                  Stack(
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      Container(
                                        height: 220,
                                        width: 150,
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
                                ],
                              ),
                            ),
                          ],
                        );
                      }
                  ),
                ),
              ),
              SizedBox(height: 20,),
              StreamBuilder(
                  stream: TestimonyServices.showTestimony(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(!snapshot.hasData) {
                      return const SizedBox(height: 0,);
                    }
                    final user = AuthController.instance.auth.currentUser;
                    final snapdata = snapshot.data!.docs;
                    return snapdata.isNotEmpty ? FutureBuilder(
                        future: FirebaseFirestore.instance.collection("users").doc(user!.uid).get(),
                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if(snapshot.connectionState == ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator(),);
                          } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && !snapshot.data!.exists) {
                            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                            return Container(
                              height: 320,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white
                              ),
                              child: Container(
                                margin: EdgeInsets.only(left: 20, right: 20, top: 40),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text("Our Stories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF1E2432)),),
                                        InkWell(
                                          onTap: () {},
                                          child: Row(
                                            children: const [
                                              Text("Testify", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF1E2432)),),
                                              SizedBox(width: 5,),
                                              Icon(Icons.arrow_forward_sharp, color: Colors.black, size: 18,),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    SizedBox(height: 50,),
                                    SingleChildScrollView(
                                      child: Container(
                                        height: 200,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  height: 170,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Colors.grey,
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              "${data["imagePath"]}"
                                                          ),
                                                          fit: BoxFit.cover
                                                      )
                                                  ),
                                                ),
                                                SizedBox(height: 10,),
                                                Center(
                                                  child: Text("${data["name"]}", style: TextStyle(color: Color(0xFF1E2432)),),
                                                )
                                              ],
                                            ),
                                            SizedBox(width: 10,),
                                            Column(
                                              children: [
                                                Container(
                                                  height: 170,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(10),
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                                SizedBox(height: 10,),
                                                const Center(
                                                  child: Text("Anonymous", style: TextStyle(color: Color(0xFF1E2432)),),
                                                )
                                              ],
                                            ),
                                            SizedBox(width: 10,),
                                            Column(
                                              children: [
                                                Container(
                                                  height: 170,
                                                  width: 120,
                                                  decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(10),
                                                      color: Colors.grey,
                                                      image: const DecorationImage(
                                                          image: AssetImage(
                                                              "images/diana-simum.jpg"
                                                          ),
                                                          fit: BoxFit.cover
                                                      )
                                                  ),
                                                ),
                                                SizedBox(height: 10,),
                                                const Center(
                                                  child: Text("Diana", style: TextStyle(color: Color(0xFF1E2432)),),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }
                          return Container(
                            height: 320,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white
                            ),
                            child: Container(
                              margin: EdgeInsets.only(left: 20, right: 20, top: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text("Our Stories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF1E2432)),),
                                      InkWell(
                                        onTap: () {},
                                        child: Row(
                                          children: const [
                                            Text("Testify", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Color(0xFF1E2432)),),
                                            SizedBox(width: 5,),
                                            Icon(Icons.arrow_forward_sharp, color: Colors.black, size: 18,),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: 50,),
                                  SingleChildScrollView(
                                    child: Container(
                                      height: 200,
                                      child: ListView(
                                        scrollDirection: Axis.horizontal,
                                        children: [
                                          Column(
                                            children: const [
                                              Center(child: CircularProgressIndicator(),),
                                              SizedBox(height: 10,),
                                              Center(
                                                child: CircularProgressIndicator(),
                                              )
                                            ],
                                          ),
                                          SizedBox(width: 10,),
                                          Column(
                                            children: const [
                                              Center(child: CircularProgressIndicator(),),
                                              SizedBox(height: 10,),
                                              Center(
                                                child: CircularProgressIndicator(),
                                              )
                                            ],
                                          ),
                                          SizedBox(width: 10,),
                                          Column(
                                            children: const [
                                              Center(
                                                child: CircularProgressIndicator(),
                                              ),
                                              SizedBox(height: 10,),
                                              Center(
                                                child: CircularProgressIndicator(),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                    ) : SizedBox();
                  }
              ),
            ],
          ),
        )
    );
  }

  Widget _buildList(DocumentSnapshot documentSnapshot) {
    final doc = documentSnapshot;
    return GestureDetector(
      onTap: (){
        Get.to(()=> const TestimonyDetailPage());
      },
      child: Container(
        height: 158,
        width: 340,
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage("images/gracious-adebayo.jpg"),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Anonymous", style: TextStyle(
                      fontSize:16,
                      fontWeight: FontWeight.bold,)
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Icon(Icons.access_time_rounded, size: 16, color: Color(0xffBEC2CE),),
                        Text("2 hours Ago", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xffBEC2CE)),)
                      ],
                    ),
                    SizedBox(height: 4,),
                    Container(
                      height: 81,
                      width: 250,
                      child: Text(doc["testimony"],
                      style: TextStyle(fontWeight: FontWeight.w200, fontSize: 16, color: Colors.black),),
                    ),
                  ]
                ),
              ],
            ),
            SizedBox(height: 5,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(),
                SizedBox(width: 11,),
                Row(
                  children: [
                    Icon(Icons.launch_rounded, size: 13.21, color: Color(0xffBEC2CE),),
                    Text("See More")
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
