import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/edit_screen.dart';
import 'package:prophetic_prayers/pages/testimony_detail_page.dart';
import 'package:prophetic_prayers/services/route_services.dart';

import '../controller/auth_controller.dart';
import '../utils/dimensions.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final user = AuthController.instance.auth.currentUser;
  final CollectionReference ref = FirebaseFirestore.instance.collection("users");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = AuthController.instance.auth.currentUser;
    return Scaffold(
      // appBar: const MyAppBar(),
      backgroundColor: const Color(0xffF7F8FA),
      body: FutureBuilder(
        future: FirebaseFirestore.instance.collection("users").doc(user?.uid).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Container(
              height: size.height,
              width: size.width,
              child: Stack(
                children: [
                  Positioned(
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 300,
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage("${data["imagePath"]}"),
                                fit: BoxFit.cover)),
                      )
                  ),
                  Positioned(
                      left: 0,
                      right: 0,
                      child: Container(
                        margin: EdgeInsets.only(left: Dimensions.prayerListScreenContainerWidth20, top: Dimensions.prayerDetailsScreenHeight60, right: Dimensions.prayerListScreenContainerWidth20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (){
                                Get.back();
                              },
                              child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                            ),
                            // Icon(
                            //   Icons.more_vert,
                            //   color: Colors.white,
                            // )
                          ],
                        ),
                      )),
                  Positioned(
                      top: Dimensions.prayerDetailsScreenHeight270,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        physics: const BouncingScrollPhysics(),
                        child: Container(
                          padding: EdgeInsets.only(left: Dimensions.pageScreenExpandedPaddingWidth20+2, right: Dimensions.prayerListScreenContainerWidth20, top: Dimensions.prayerListStackPositionedContainerHeight20),
                          width: MediaQuery.of(context).size.width,
                          height: Dimensions.prayerDetailsScreenHeight500,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(Dimensions.prayerListStackPositionedContainerHeight20),
                                  topRight: Radius.circular(Dimensions.prayerListStackPositionedContainerHeight20)),
                              color: Colors.white),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.person,
                                          color: Color(0xFFBEC2CE),
                                          size: Dimensions.prayerListScreenContainerWidth15,
                                        ),
                                        SizedBox(width: Dimensions.prayerListScreenContainerWidth6-1,),
                                        Text(
                                          //prayer id
                                          "Profile Settings",
                                          style: TextStyle(
                                              fontSize: Dimensions.prayerListScreenContainerWidth14,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xFFBEC2CE)),
                                        )
                                      ],
                                    ),
                                    Icon(
                                      Icons.bookmark,
                                      color: Color(0xFF1E2432),
                                      size: Dimensions.prayerListScreenContainerWidth19,
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: Dimensions.prayerDetailScreenHeight7,
                                ),
                                Text(
                                  //title
                                  "${data["name"]}",
                                  style: TextStyle(
                                      color: Color(0xFF1E2432),
                                      fontSize: Dimensions.prayerListStackPositionedContainerTextWidth28,
                                      fontWeight: FontWeight.w900),
                                  textAlign: TextAlign.start,
                                ),
                                SizedBox(height: Dimensions.pageScreenExpandedRadiusHeight10*2),
                                Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text("${data["email"]}", style: TextStyle(color: Color(0xFF1E2432), fontSize: Dimensions.prayerListScreenContainerWidth18, fontWeight: FontWeight.bold),),
                                        SizedBox(height: Dimensions.pageScreenExpandedRadiusHeight10*2,),
                                        SizedBox(
                                          height: Dimensions.prayerDetailScreenHeight18,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                InkWell(
                                                  onTap: (){
                                                    Get.toNamed(RouteServices.EDITPROFILESCREEN);
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons.notifications,
                                                        size: Dimensions.prayerDetailScreenHeight29,
                                                        color: Color(0xFFD1D1D6),
                                                      ),
                                                      SizedBox(
                                                        height: Dimensions.prayerDetailScreenHeight8,
                                                      ),
                                                      Text(
                                                        "Edit Profile",
                                                        style:TextStyle(
                                                            fontSize: Dimensions.prayerListScreenContainerWidth14,
                                                            fontWeight: FontWeight.w200,
                                                            color: Color(0xFF1E2432)),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              width: Dimensions.prayerListScreenContainerWidth6+2,
                                            ),
                                            GestureDetector(
                                              onTap: (() {
                                                Get.toNamed(RouteServices.CREATETESTIMONYSCREEN);
                                              }),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    children: [
                                                      Icon(
                                                        Icons.edit,
                                                        size: Dimensions.prayerDetailScreenHeight29,
                                                        color: Color(0xFFD1D1D6),
                                                      ),
                                                      SizedBox(
                                                        height: Dimensions.prayerDetailScreenHeight8,
                                                      ),
                                                      Text(
                                                        "Testify",
                                                        style:TextStyle(
                                                            fontSize: Dimensions.prayerListScreenContainerWidth14,
                                                            fontWeight: FontWeight.w200,
                                                            color: Color(0xFF1E2432)),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: Dimensions.prayerListScreenContainerWidth6+2,
                                            ),
                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.list,
                                                  size: Dimensions.prayerDetailScreenHeight29,
                                                  color: Color(0xFFD1D1D6),
                                                ),
                                                SizedBox(
                                                  height: Dimensions.prayerDetailScreenHeight8,
                                                ),
                                                Text(
                                                  "prayers",
                                                  style: TextStyle(
                                                      fontSize: Dimensions.prayerListScreenContainerWidth14,
                                                      fontWeight: FontWeight.w200,
                                                      color: Color(0xFF1E2432)),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: Dimensions.pageScreenSizedBoxHeight12,
                                            ),
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: Dimensions.pageScreenExpandedRadiusHeight10,),
                              ],
                            ),
                          ),
                        ),
                      )
                  )
                ],
              ),
            );
          }
          return Container();
        },
      )
      /*SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Text("Profile Settings", style: TextStyle(fontWeight: FontWeight.w300, color: Color(0xff515BDE).withOpacity(0.6)),)),
                GestureDetector(
                  onTap: () {
                    AuthController.instance.Logout();
                  },
                  child: Container(
                    margin: EdgeInsets.only(right: 10),
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: const Color(0xff515BDE)
                    ),
                    child: const Center(child:
                    Text("SignOut",
                      style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w400),),),
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
              return FutureBuilder(
                  future: FirebaseFirestore.instance.collection("users").doc(user?.uid).get(),
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if(snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Center(child: Icon(Icons.person)),
                      );
                    } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!.exists) {
                      Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                      return Container(
                        height: 200,
                        width: size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Colors.white
                        ),
                        child: Container(
                          margin: EdgeInsets.only(top: 40),
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    Get.to(()=> const EditScreen());
                                  });
                                },
                                child: Stack(
                                  children: [
                                    Positioned(
                                        child: Container(
                                          height: 90,
                                          width: 90,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(color: Colors.black, width: 1),
                                            image: DecorationImage(
                                                image: NetworkImage("${data["imagePath"]}"),
                                                fit: BoxFit.cover
                                            ),
                                          ),
                                        )
                                    ),
                                    Positioned(
                                        bottom: 0,
                                        right: 0,
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: const BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.white
                                          ),
                                          child: Container(
                                            height: 20,
                                            width: 20,
                                            decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.black
                                            ),
                                            child: const Center(
                                              child: Text("+", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),),
                                            ),
                                          ),
                                        )
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    }
                    return Container(
                      height: 30,
                      width: 30,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("images/Icon-48.png"),
                              fit: BoxFit.cover
                          )
                      ),
                    );
                  }
              );
            }),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Text("Contact Details", style: TextStyle(fontWeight: FontWeight.w300, color: Color(0xff515BDE).withOpacity(0.6)),)),
              ],
            ),
            SizedBox(height: 10,),
            Container(
              height: 300,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FutureBuilder(
                      future: FirebaseFirestore.instance.collection("users").doc(user?.uid).get(),
                      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                        if(snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(),);
                        } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!.exists) {
                          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                          return Container(
                            margin: EdgeInsets.only(left: 20, right: 20),
                            child: Column(
                              children: [
                                ExpansionTile(
                                  title: ListTile(
                                      leading: Icon(Icons.person, color: Color(0xff515BDE),),
                                      title: Text("Name"),
                                    ),
                                  children: [
                                    ListTile(
                                      title: Text("${data["name"]}"),
                                    )
                                  ],
                                ),
                                ExpansionTile(
                                  title: ListTile(
                                    leading: Icon(Icons.email, color: Color(0xff515BDE),),
                                    title: Text("Email"),
                                  ),
                                  children: [
                                    ListTile(
                                      title: Text("${data["email"]}"),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          );
                        }
                        return const Center(child: Text("No testimonies yet "),);
                      }
                  ),
                  SizedBox(height: 20,),

                ],
              ),
            ),
            SizedBox(height: 20,),
            StreamBuilder(
                stream: FirebaseFirestore.instance.collection("testimonies").snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(!snapshot.hasData) {
                    return const Center(child: Text("No Testimonies yet be the first to testify"));
                  }
                  List snapdata = snapshot.data!.docs;
                  return snapdata.isNotEmpty ? Container(
                    height: 150,
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.white
                    ),
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          String useruid = snapdata[index]["useruid"];
                          return InkWell(
                            splashColor: Colors.grey,
                            onTap: (){
                              Get.to(()=> const TestimonyDetailPage());
                            },
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 15, right: 15, top: 10),
                                  child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      FutureBuilder(
                                          future: FirebaseFirestore.instance.collection("users").doc(useruid).get(),
                                          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot>snapshot) {
                                            if(!snapshot.hasData) {
                                              return Container();
                                            }
                                            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                                            return Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.grey),
                                                    shape: BoxShape.circle
                                                ),
                                                child: Center(child: Text("${data["name"]}"[0].toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)));
                                          }
                                      ),
                                      SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("${snapdata[index]["title"]}", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
                                          Row(
                                            children: [
                                              const Icon(Icons.access_time, size: 14, color: Colors.grey,),
                                              SizedBox(width: 5,),
                                              Text("${snapdata[index]["timestamp"]}", style: const TextStyle(fontWeight: FontWeight.w300, fontSize: 14, color: Colors.grey),),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 60,
                                        decoration: const BoxDecoration(
                                            border: Border(
                                                left: BorderSide(
                                                    width: 4.0,
                                                    color: Colors.black
                                                )
                                            )
                                        ),

                                      ),
                                      SizedBox(width: 10,),
                                      Column(
                                        children: [
                                          Container(
                                              width: 300,
                                              child: Text("${snapdata[index]["testimonies"]}",
                                                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,),

                                              )
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                    ),
                  ): SizedBox();
                }
            ),
          ],
        ),
      )*/
    );
  }
}
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = AuthController.instance.auth.currentUser;
    // TODO: implement build
    return Container(
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
      padding: const EdgeInsets.only(left: 24, right: 24, top: 46),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
              future: FirebaseFirestore.instance.collection("users").doc(user?.uid).get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Welcome", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),);
                } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!.exists) {
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return Text("Welcome ${data["name"]}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),);
                }
                return const Text("Welcome", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),);
              }
          ),
          FutureBuilder(
              future: FirebaseFirestore.instance.collection("users").doc(user?.uid).get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("images/Icon-48.png"),
                          fit: BoxFit.cover
                        )
                    ),
                  );
                } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!.exists) {
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage("${data["imagePath"]}"),
                            fit: BoxFit.cover
                        )
                    ),
                  );
                }
                return Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("images/Icon-48.png"),
                        fit: BoxFit.cover
                      )
                  ),
                );
              }
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(126);
}
