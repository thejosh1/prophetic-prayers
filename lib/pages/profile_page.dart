
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
    return Scaffold(
      appBar: const MyAppBar(),
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: ref.doc(user!.uid).get(),
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.black),),);
          }
          if(snapshot.hasData && snapshot.data!.exists) {
            Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
            return Container(
              margin: EdgeInsets.only(top: Dimensions.prayerListScreenContainerheight22),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  SizedBox(height: 10,),
                  ProfileWidget(
                    imagePath: data["imagePath"],
                    onClicked: () async {},
                  ),
                  SizedBox(height: 24,),
                  buildName(data["name"]),
                  SizedBox(height: 4,),
                  buildEmail(data["email"]),
                  SizedBox(height: 4,),
                  buildNumber(data["phonenumber"]),
                  SizedBox(height: 100,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 80),
                    child: Row(
                    children: [
                      Text("do you want to SignOut?", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w200)),
                      SizedBox(width: 5,),

                      GestureDetector(
                        onTap: () {
                          AuthController.instance.Logout();
                        },
                        child: const Text("SignOut", style: TextStyle(color: Color(0xff515BDE), fontSize: 14, fontWeight: FontWeight.w200),),
                      )
                    ],
                  ),)
                ],
              ),
            );
            //   Column(
            //   children: [
            //     Text("${data["name"]}"),
            //     Text("${data["email"]}"),
            //     Text("${data["phonenumber"]}"),
            //     Container(
            //       height: 100,
            //       width: 100,
            //       decoration: BoxDecoration(
            //           image: DecorationImage(
            //               image: NetworkImage("${data["imagePath"]}"),
            //               fit: BoxFit.cover
            //           )
            //       ),
            //     )
            //   ],
            // );
          }
          return const Center(child: Text("no data"),);
        },
      )
    );
  }

  Widget buildName(String username) {
    return Center(
      child: Text(
        username,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
    );
  }

  Widget buildEmail(String email) {
    return Center(
      child: Text(
          email,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
    );
  }

  Widget buildNumber(String phonenumber) {
    return Center(
      child: Text(
        phonenumber,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
    );
  }
}
class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xffF7F8FA),
      padding: const EdgeInsets.only(left: 24, right: 24, top: 46),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(onTap: (){
                Get.back();
              },child: const Icon(Icons.arrow_back_outlined)),
             // const Icon(Icons.more_vert),
            ],
          ),
          const SizedBox(height: 21),
          const Text(
            'My Account',
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(126);
}
