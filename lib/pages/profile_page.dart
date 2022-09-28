import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/services/route_services.dart';
import 'package:prophetic_prayers/services/testimony_services.dart';

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
  final Collections = FirebaseFirestore.instance.collection("testimonies").doc().id;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final user = AuthController.instance.auth.currentUser;
    return Scaffold(
        // appBar: const MyAppBar(),
        backgroundColor: const Color(0xffF7F8FA),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("users")
                .doc(user?.uid)
                .get(),
            builder: (BuildContext context,
                AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData &&
                  snapshot.data!.exists) {
                Map<String, dynamic> data =
                    snapshot.data!.data() as Map<String, dynamic>;
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
                          )),
                      Positioned(
                          top: Dimensions.Height270,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            physics: const BouncingScrollPhysics(),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: Dimensions.Width20 + 2,
                                  right: Dimensions.Width20,
                                  top: Dimensions.Height20),
                              width: MediaQuery.of(context).size.width,
                              height: Dimensions.Height500,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topLeft:
                                          Radius.circular(Dimensions.Height20),
                                      topRight:
                                          Radius.circular(Dimensions.Height20)),
                                  color: Colors.white),
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.person,
                                              color: const Color(0xFFBEC2CE),
                                              size: Dimensions.Width15,
                                            ),
                                            SizedBox(
                                              width: Dimensions.Width6 - 1,
                                            ),
                                            Text(
                                              //prayer id
                                              "Profile Settings",
                                              style: TextStyle(
                                                  fontSize: Dimensions.Width14,
                                                  fontWeight: FontWeight.bold,
                                                  color: Color(0xFFBEC2CE)),
                                            )
                                          ],
                                        ),
                                        Icon(
                                          Icons.bookmark,
                                          color: Color(0xFF1E2432),
                                          size: Dimensions.Width19,
                                        )
                                      ],
                                    ),
                                    SizedBox(
                                      height: Dimensions.Height7,
                                    ),
                                    Text(
                                      //title
                                      "${data["name"]}",
                                      style: TextStyle(
                                          color: Color(0xFF1E2432),
                                          fontSize: Dimensions.Width28,
                                          fontWeight: FontWeight.w900),
                                      textAlign: TextAlign.start,
                                    ),
                                    SizedBox(height: Dimensions.Height10 * 2),
                                    Expanded(
                                      child: SingleChildScrollView(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "${data["email"]}",
                                              style: TextStyle(
                                                  color: Color(0xFF1E2432),
                                                  fontSize: Dimensions.Width18,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            SizedBox(
                                              height: Dimensions.Height10 * 2,
                                            ),
                                            SizedBox(
                                              height: Dimensions.Height18,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        Get.toNamed(RouteServices
                                                            .EDITPROFILESCREEN);
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Icon(
                                                            Icons.notifications,
                                                            size: Dimensions
                                                                .Height29,
                                                            color: Color(
                                                                0xFFD1D1D6),
                                                          ),
                                                          SizedBox(
                                                            height: Dimensions
                                                                .Height8,
                                                          ),
                                                          Text(
                                                            "Edit Profile",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    Dimensions
                                                                        .Width14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200,
                                                                color: Color(
                                                                    0xFF1E2432)),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: Dimensions.Width6 + 2,
                                                ),
                                                GestureDetector(
                                                  onTap: (() {
                                                    Get.toNamed(RouteServices
                                                        .CREATETESTIMONYSCREEN);
                                                  }),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Icon(
                                                            Icons.edit,
                                                            size: Dimensions
                                                                .Height29,
                                                            color: Color(
                                                                0xFFD1D1D6),
                                                          ),
                                                          SizedBox(
                                                            height: Dimensions
                                                                .Height8,
                                                          ),
                                                          Text(
                                                            "Testify",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    Dimensions
                                                                        .Width14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200,
                                                                color: Color(
                                                                    0xFF1E2432)),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Dimensions.Width6 + 2,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    Get.toNamed(RouteServices.PLANLISTSCREEN);
                                                  },
                                                  child: Column(
                                                    children: [
                                                      Icon(
                                                        Icons.list,
                                                        size: Dimensions.Height29,
                                                        color: Color(0xFFD1D1D6),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Dimensions.Height8,
                                                      ),
                                                      Text(
                                                        "prayers",
                                                        style: TextStyle(
                                                            fontSize: Dimensions
                                                                .Width14,
                                                            fontWeight:
                                                                FontWeight.w200,
                                                            color: Color(
                                                                0xFF1E2432)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: Dimensions
                                                      .pageScreenSizedBoxHeight12,
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        AuthController.instance
                                                            .Logout();
                                                      },
                                                      child: Column(
                                                        children: [
                                                          Icon(
                                                            Icons.logout,
                                                            size: Dimensions
                                                                .Height29,
                                                            color: Color(
                                                                0xFFD1D1D6),
                                                          ),
                                                          SizedBox(
                                                            height: Dimensions
                                                                .Height8,
                                                          ),
                                                          Text(
                                                            "Sign out",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    Dimensions
                                                                        .Width14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w200,
                                                                color: Color(
                                                                    0xFF1E2432)),
                                                          ),
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  width: Dimensions.Width6 + 2,
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection("testimonies")
                                                .where("useruid",
                                                    isEqualTo: user?.uid)
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<QuerySnapshot>
                                                    snapshot) {
                                              if (!snapshot.hasData) {
                                                return const Center(
                                                  child: Text(
                                                      "You don't have any Testimonies yet"),
                                                );
                                              }
                                              List snapdata =
                                                  snapshot.data!.docs;
                                              return snapdata.isNotEmpty
                                                  ? Column(
                                                      children: [
                                                        SizedBox(
                                                          height: Dimensions
                                                              .Height10,
                                                        ),
                                                        Container(
                                                          height: Dimensions
                                                              .Height270,
                                                          width: size.width,
                                                          child:
                                                              ListView.builder(
                                                                  physics:
                                                                      const BouncingScrollPhysics(),
                                                                  itemCount:
                                                                      snapdata
                                                                          .length,
                                                                  itemBuilder:
                                                                      (BuildContext
                                                                              context,
                                                                          index) {
                                                                    String
                                                                        useruid =
                                                                        snapdata[index]
                                                                            [
                                                                            "useruid"];
                                                                    return Column(
                                                                        children: [
                                                                          InkWell(
                                                                            splashColor:
                                                                                Colors.grey,
                                                                            onTap:
                                                                                () {
                                                                              Get.toNamed(RouteServices.TESTIMONYDETAILSCREEN, arguments: [
                                                                                "${snapdata[index]["title"]}",
                                                                                "${snapdata[index]["testimonies"]}",
                                                                                "${snapdata[index]["timestamp"]}"
                                                                              ]);
                                                                            },
                                                                            child:
                                                                                Row(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                Container(
                                                                                  height: 80,
                                                                                  width: 80,
                                                                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), border: Border.all(color: Colors.grey, width: 2), color: Colors.grey
                                                                                      //color: data[1]
                                                                                      ),
                                                                                  child: FutureBuilder(
                                                                                    future: FirebaseFirestore.instance.collection("users").doc(useruid).get(),
                                                                                    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                                                                                      if (!snapshot.hasData) {
                                                                                        return Container();
                                                                                      }
                                                                                      Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                                                                                      return Center(child: Text("${data["name"]}"[0].toUpperCase(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white)));
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
                                                                                        Text(
                                                                                          "${snapdata[index]["title"]}",
                                                                                          maxLines: 1,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                          style: TextStyle(fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 3,
                                                                                        ),
                                                                                        Text(
                                                                                          "${snapdata[index]["testimonies"]}",
                                                                                          maxLines: 2,
                                                                                          overflow: TextOverflow.ellipsis,
                                                                                        ),
                                                                                        SizedBox(
                                                                                          height: 3,
                                                                                        ),
                                                                                        Text("${snapdata[index]["timestamp"]}"),
                                                                                        SizedBox(
                                                                                          height: 3,
                                                                                        ),
                                                                                        Row(
                                                                                          children: [
                                                                                            Wrap(
                                                                                                children: List.generate(
                                                                                                    5,
                                                                                                    (index) => const Icon(
                                                                                                          Icons.star,
                                                                                                          color: Colors.amberAccent,
                                                                                                          size: 15,
                                                                                                        ))),
                                                                                          ],
                                                                                        ),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                )),
                                                                                PopupMenuButton(
                                                                                  itemBuilder: (_) {
                                                                                    return [
                                                                                      PopupMenuItem<String>(value: "delete", child: const Text("Delete"))
                                                                                    ];
                                                                                  },
                                                                                  onSelected: (value) async {
                                                                                    if (value == "delete") {
                                                                                      await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                                                                        await myTransaction.delete(snapshot.data!.docs[index].reference);
                                                                                      });
                                                                                      print("deleted");
                                                                                    }
                                                                                  },
                                                                                  child: const Icon(
                                                                                    Icons.more_horiz,
                                                                                    size: 24,
                                                                                  ),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                20,
                                                                          ),
                                                                        ]);
                                                                  }),
                                                        ),
                                                      ],
                                                    )
                                                  : Container();
                                            }),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ))
                    ],
                  ),
                );
              }
              return Container();
            },
          ),
        ));
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
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            blurRadius: 0.5,
            spreadRadius: 0.5,
            offset: Offset(0, 3),
            color: Colors.transparent)
      ]),
      padding: const EdgeInsets.only(left: 24, right: 24, top: 46),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("users")
                  .doc(user?.uid)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text(
                    "Welcome",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  );
                } else if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data!.exists) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Text(
                    "Welcome ${data["name"]}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  );
                }
                return const Text(
                  "Welcome",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                );
              }),
          FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("users")
                  .doc(user?.uid)
                  .get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("images/Icon-48.png"),
                            fit: BoxFit.cover)),
                  );
                } else if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.hasData &&
                    snapshot.data!.exists) {
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;
                  return Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage("${data["imagePath"]}"),
                            fit: BoxFit.cover)),
                  );
                }
                return Container(
                  height: 30,
                  width: 30,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("images/Icon-48.png"),
                          fit: BoxFit.cover)),
                );
              }),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(126);
}
