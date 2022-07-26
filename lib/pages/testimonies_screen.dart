import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prophetic_prayers/pages/create_testimony_screen.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/testimony_detail_page.dart';
import '../controller/auth_controller.dart';
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
    PageController page_controller = PageController(viewportFraction: 0.8);
    List planNames = ["Children", "Marriage", "Business", "Work", "Finance"];
    return Scaffold(
      backgroundColor: Color(0xffF7F8FA),
      appBar: MyAppBar(),
      body: ListView(
        children: [
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(height: 10,),
                Row(
                  children: [
                    Expanded(child: Container()),
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      height: 30,
                      width: 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(color: const Color(0xff515BDE),),
                        color: Colors.white
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.person, color: const Color(0xff515BDE),),
                          GestureDetector(
                            onTap: (){Get.to(()=> const CreateTestimonyScreen());
                            },
                            child: const Text("Testify", style: TextStyle(color: Color(0xff515BDE),),)
                          )
                        ],
                      ),
                    )
                  ],
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
                        height: 200,
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
                                                    border: Border.all(color: Colors.black),
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
                                                  const Icon(Icons.access_time, size: 18,),
                                                  SizedBox(width: 5,),
                                                  Text("${snapdata[index]["timestamp"]}", style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),),
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
                                            height: 120,
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
          )
        ],
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
