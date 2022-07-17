
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/utils/dimensions.dart';

import '../controller/auth_controller.dart';
import '../widgets/profile_widget.dart';

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
      body: Container(
        height: 400,
        width: size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.white
        ),
        child: FutureBuilder(
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
                return Column(
                  children: [
                    Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: NetworkImage("${data["imagePath"]}"),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.bolt, color: Colors.amberAccent,),
                            Text("Streak")
                          ],
                        ),
                        SizedBox(width: 5,),
                        Row(
                          children: const [
                            Icon(Icons.sunny, color: Colors.amberAccent,),
                            Text("Weeks")
                          ],
                        ),
                      ],
                    ),

                  ],
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
        // Column(
        //   children: [
        //     Stack(
        //       children: [
        //         Container(
        //           height: 60,
        //           width: 60,
        //           decoration: BoxDecoration(
        //             shape: BoxShape.circle,
        //             border: Border.all(color: Colors.black, width: 1),
        //             image: DecorationImage(
        //               image: NetworkImage("")
        //             )
        //           ),
        //         )
        //       ],
        //     )
        //   ],
        // ),
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
