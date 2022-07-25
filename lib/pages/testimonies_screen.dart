import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prophetic_prayers/pages/create_testimony_screen.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/testimony_detail_page.dart';
import '../controller/auth_controller.dart';
import '../services/testimony_services.dart';
import '../widgets/big_text.dart';

class TestimoniesScreen extends StatefulWidget {
  const TestimoniesScreen({Key? key}) : super(key: key);

  @override
  State<TestimoniesScreen> createState() => _TestimoniesScreenState();
}

class _TestimoniesScreenState extends State<TestimoniesScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: Color(0xffF7F8FA),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: true,
            toolbarHeight: 80,
            title: Container(
                margin: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Icon(Icons.arrow_back, size: 24,),
                    SizedBox(width: 20,),
                    BigText(text: "Testimony"),
                  ],
                )
            ),
            backgroundColor: Colors.white,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20),)
                ),
                child: const Center(child: Text("Testimonies", style: TextStyle(fontSize: 26),),),
                width: double.maxFinite,
                padding: EdgeInsets.only(top: 5, bottom: 10),
              ),
            ),
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset("images/child(36).jpg", fit: BoxFit.cover,),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(

                )
              ],
            ),
          )
        ],
      )
      // ListView(
      //   children: [
      //     SingleChildScrollView(
      //       child: Column(
      //         children: <Widget>[
      //           SizedBox(height: 10,),
      //           Row(
      //             children: [
      //               Expanded(child: Container()),
      //               Container(
      //                 margin: EdgeInsets.only(right: 10),
      //                 height: 30,
      //                 width: 100,
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(40),
      //                   color: Colors.grey
      //                 ),
      //                 child: Row(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     Icon(Icons.person),
      //                     GestureDetector(
      //                       onTap: (){Get.to(()=> const CreateTestimonyScreen());
      //                       },
      //                       child: Text("Testify")
      //                     )
      //                   ],
      //                 ),
      //               )
      //             ],
      //           ),
      //           SizedBox(height: 20,),
      //           StreamBuilder(
      //               stream: FirebaseFirestore.instance.collection("testimonies").snapshots(),
      //               builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
      //                 if(!snapshot.hasData) {
      //                   return const Center(child: Text("No Testimonies yet be the first to testify"));
      //                 }
      //                 List snapdata = snapshot.data!.docs;
      //                 return snapdata.isNotEmpty ? SizedBox(
      //                   height: 200,
      //                   child: ListView.builder(
      //                       itemCount: snapshot.data!.docs.length,
      //                       itemBuilder: (context, index) {
      //                         String useruid = snapdata[index]["useruid"];
      //                         return InkWell(
      //                           splashColor: Colors.grey,
      //                           onTap: (){
      //                             Get.to(()=> const TestimonyDetailPage());
      //                           },
      //                           child: Container(
      //                               height: 300,
      //                               width: size.width,
      //                               decoration: BoxDecoration(
      //                                   borderRadius: BorderRadius.circular(30),
      //                                   color: Colors.white
      //                               ),
      //                               child: Column(
      //                                 children: [
      //                                   Container(
      //                                     margin: EdgeInsets.only(left: 15, right: 15),
      //                                     child: Row(
      //                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                                       children: [
      //                                         FutureBuilder(
      //                                           future: FirebaseFirestore.instance.collection("users").doc(useruid).get(),
      //                                           builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot>snapshot) {
      //                                             if(!snapshot.hasData) {
      //                                               return Container();
      //                                             }
      //                                             Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
      //                                             return Container(
      //                                                 height: 30,
      //                                                 width: 30,
      //                                                 decoration: BoxDecoration(
      //                                                   border: Border.all(color: Colors.black),
      //                                                   shape: BoxShape.circle
      //                                                 ),
      //                                                 child: Center(child: Text("${data["name"]}"[0].toUpperCase(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)));
      //                                           }
      //                                         ),
      //                                         Text("${snapdata[index]["title"]}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
      //                                         Text("created ${snapdata[index]["timestamp"]}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)
      //                                       ],
      //                                     ),
      //                                   ),
      //                                   SizedBox(height: 20,),
      //                                   Container(
      //                                     margin: EdgeInsets.only(left: 20),
      //                                     child: Row(
      //                                       crossAxisAlignment: CrossAxisAlignment.start,
      //                                       children: [
      //                                         Container(
      //                                           height: 100,
      //                                           decoration: const BoxDecoration(
      //                                             border: Border(
      //                                               left: BorderSide(
      //                                                 width: 8.0,
      //                                                 color: Colors.black
      //                                               )
      //                                             )
      //                                           ),
      //
      //                                         ),
      //                                         SizedBox(width: 10,),
      //                                         Column(
      //                                           children: [
      //                                             Container(
      //                                               width: 300,
      //                                                 child: Text("${snapdata[index]["testimonies"]}", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16,),
      //                                                 )
      //                                             ),
      //                                           ],
      //                                         ),
      //                                       ],
      //                                     ),
      //                                   )
      //                                 ],
      //                               )
      //                           ),
      //                         );
      //                       }
      //                   ),
      //                 ): SizedBox();
      //               }
      //           ),
      //         ],
      //       ),
      //     )
      //   ],
      // ),
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
                            image: AssetImage("images/Icon-48.png")
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
                          image: AssetImage("images/Icon-48.png")
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
