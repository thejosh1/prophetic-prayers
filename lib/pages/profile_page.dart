
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:prophetic_prayers/services/testimony_services.dart';
import 'package:prophetic_prayers/utils/dimensions.dart';

import '../controller/auth_controller.dart';

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
      appBar: const MyAppBar(),
      backgroundColor: const Color(0xffF7F8FA),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Container(
              height: 100,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: Colors.white
              ),
              child: Column(
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
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Name:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                    Container(
                                      width: 150,
                                      child: Text("${data["name"]}".toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16), overflow: TextOverflow.ellipsis,),
                                    )
                                  ],
                                ),
                                SizedBox(height: 20,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Email:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                                    Container(
                                      width: 150,
                                      child: Text("${data["email"]}".toUpperCase(), style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16), overflow: TextOverflow.ellipsis,),
                                    )
                                  ],
                                ),
                                SizedBox(width: 20,),
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
                    return Center(child: CircularProgressIndicator());
                  }
                  List snapdata = snapshot.data!.docs;
                  return snapdata.isNotEmpty ? Container(
                    height: 200,
                    child: ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, index) {
                          String useruid = snapdata[index]["useruid"];
                          return Container(
                              height: 300,
                              width: size.width,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.white
                              ),
                              child: Column(
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                      border: Border.all(color: Colors.black),
                                                      shape: BoxShape.circle
                                                  ),
                                                  child: Center(child: Text("${data["name"]}"[0].toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)));
                                            }
                                        ),
                                        Text("${snapdata[index]["title"]}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),),
                                        Text("created ${snapdata[index]["timestamp"]}", style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),)
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 20,),
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 100,
                                          decoration: const BoxDecoration(
                                              border: Border(
                                                  left: BorderSide(
                                                      width: 8.0,
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
                                                  style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16,),
                                                )
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )
                          );
                        }
                    ),
                  ): SizedBox();
                }
            ),
            // StreamBuilder(
            //     stream: TestimonyServices.showTestimony(),
            //     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //       if(!snapshot.hasData) {
            //         return Center(child: CircularProgressIndicator());
            //       }
            //       final snapdata = snapshot.data!.docs;
            //       return Container(
            //         height: 420,
            //         width: size.width,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(30),
            //             color: Colors.white
            //         ),
            //         child: ListView.builder(
            //             itemCount: snapdata.length,
            //             scrollDirection: Axis.horizontal,
            //             itemBuilder: (BuildContext context, index) {
            //               return FutureBuilder(
            //                   future: FirebaseFirestore.instance.collection("users").doc(snapdata[index]["useruid"].toString()).get(),
            //                   builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot>snapshot) {
            //                     if(snapshot.connectionState == ConnectionState.waiting) {
            //                       return Center(child: CircularProgressIndicator(),);
            //                     } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!.exists) {
            //                       Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            //                       return Column(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           Row(
            //                             children: [
            //                               Container(
            //                                 width: 40,
            //                                 height: 40,
            //                                 decoration: BoxDecoration(
            //                                     border: Border.all(color: Colors.black),
            //                                     shape: BoxShape.circle
            //                                 ),
            //                                 child: Center(child: Text("${data["name"]}"[0]),),
            //                               ),
            //                               SizedBox(width: 10,),
            //                               Text("${DateFormat.MMMEd().format(snapdata[index]["timestamp"])}")
            //                             ],
            //                           ),
            //                           SizedBox(height: 20,),
            //                           Text("${snapdata[index]["prayertype"]}"),
            //                           SizedBox(height: 20,),
            //                           Container(
            //                             width: 250,
            //                             decoration: BoxDecoration(
            //                                 border: Border(
            //                                     left: BorderSide(color: Colors.black, width: 16)
            //                                 )
            //                             ),
            //                             child: Text("${snapdata[index]["testimonies"]}"),
            //                           )
            //                         ],
            //                       );
            //                     }
            //                     return SizedBox();
            //                   }
            //               );
            //             }
            //         ),
            //       );
            //     }
            // )
          ],
        ),
      )
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
                  return Text("${data["name"]}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),);
                }
                return Text("Welcome", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),);
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
