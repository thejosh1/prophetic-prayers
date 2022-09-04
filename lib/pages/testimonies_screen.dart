import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prophetic_prayers/pages/create_testimony_screen.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/testimony_detail_page.dart';
import 'package:prophetic_prayers/services/route_services.dart';
import '../controller/auth_controller.dart';

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
      backgroundColor: Color(0xffF7F8FA),
      appBar: MyAppBar(),
      body:  SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Container(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(left: 20, right: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("testimonies").snapshots(),
                        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if(!snapshot.hasData) {
                            return const Center(child: Text("No testimonies yet be the first to testify"),);
                          }
                          List snapdata = snapshot.data!.docs;
                          return snapdata.isNotEmpty ? Container(
                            height: size.height,
                            width: size.width,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        const Text(
                                          "Testimonies",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w800,
                                              color: Color(0xFF1E2432)),
                                        ),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Container(
                                          height: 27,
                                          width: 27,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8),
                                              color: Color(0xFFE2952A)),
                                          child: Center(
                                            child: Text(
                                              "${int.parse(snapdata.length.toString())}",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w800,
                                                  color: Color(0xFF1E2432)),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(RouteServices.CREATETESTIMONYSCREEN);

                                      },
                                      child: Container(
                                        width: 154,
                                        height: 28,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(20),
                                          border: Border.all(color: Color(0xFF515BDE)),
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.edit,
                                              color: Color(0xFF515BDE),
                                            ),
                                            Text("Testify")
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(height: 30,),
                                Container(
                                  height: 600,
                                  width: size.width,
                                  child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      itemCount: snapdata.length,
                                      itemBuilder: (BuildContext context, index) {
                                        String useruid = snapdata[index]["useruid"];
                                        return Column(
                                            children: [
                                              InkWell(
                                                splashColor: Colors.grey,
                                                onTap: (){
                                                  Get.toNamed(RouteServices.TESTIMONYDETAILSCREEN, arguments: [
                                                    "${snapdata[index]["title"]}",
                                                    "${snapdata[index]["testimonies"]}",
                                                    "${snapdata[index]["timestamp"]}"
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
                                                          color: Colors.grey
                                                        //color: data[1]
                                                      ),
                                                      child: FutureBuilder(
                                                        future: FirebaseFirestore.instance.collection("users").doc(useruid).get(),
                                                        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                                          if(!snapshot.hasData) {
                                                            return Container();
                                                          }
                                                          Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                                                          return Center(
                                                              child: Text("${data["name"]}"[0].toUpperCase(),
                                                                  style: const TextStyle(
                                                                      fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white))
                                                          );
                                                        },
                                                      ),

                                                    ),
                                                    Expanded(
                                                        child: Container(
                                                          height: 100,
                                                          child: Padding(
                                                            padding: const EdgeInsets.only(left: 10),
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                Text("${snapdata[index]["title"]}",
                                                                  maxLines: 1,
                                                                  overflow: TextOverflow.ellipsis, style: TextStyle(fontWeight: FontWeight.bold),),
                                                                SizedBox(height: 3,),
                                                                Text("${snapdata[index]["testimonies"]}", maxLines: 2, overflow: TextOverflow.ellipsis,),
                                                                SizedBox(height: 3,),
                                                                Text("${snapdata[index]["timestamp"]}"),
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
                                            ]
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ): Container();
                        }),

                  ],
                ),
              )
            ],
          ),
        ),
      ),

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
