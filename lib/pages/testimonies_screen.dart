import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prophetic_prayers/pages/create_testimony_screen.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/testimony_detail_page.dart';
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
      body: /*Container(
        child: ListView(
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
                          border: Border.all(color: Colors.white,),
                          color: const Color(0xff515BDE)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person, color: Colors.white,),
                            GestureDetector(
                              onTap: (){Get.to(()=> const CreateTestimonyScreen(), arguments: ["Prophetic Prayers For Children"]);
                              },
                              child: const Text("Testify", style: TextStyle(color: Colors.white,),)
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
                          height: size.width,
                          width: size.width,
                          child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                String useruid = snapdata[index]["useruid"];
                                return Column(
                                  children: [
                                    InkWell(
                                      splashColor: Colors.grey,
                                      onTap: (){
                                        Get.to(()=> const TestimonyDetailPage());
                                      },
                                      child: Container(
                                        height: 200,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20),
                                            color: Colors.blue
                                        ),
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
                                                          child: Center(child: Text("${data["name"]}"[0].toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)));
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
                                                          color: Colors.grey
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
                                      ),
                                    ),
                                    SizedBox(height: 20,)
                                  ],
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
      )*/ Text("coming soon")
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
