import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../base/no_data_page.dart';
import '../../../controller/auth_controllers/auth_controller.dart';
import '../../../services/route_services.dart';
import '../../../utils/dimensions.dart';
import '../../../base/custom_loader.dart';

class UserTestimonyPage extends StatelessWidget {
  const UserTestimonyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    User user = AuthController.instance.auth.currentUser!;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection("testimonies").where("useruid", isEqualTo: user?.uid).snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot>snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: CustomLoader());
              }
              List snapdata = snapshot.data!.docs;
              return snapdata.isNotEmpty ? Column(
                children: [
                  SizedBox(
                    height: Dimensions.Height10,
                  ),
                  Container(
                    height: size.height,
                    width: size.width,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: snapdata.length,
                        itemBuilder: (BuildContext context, index) {
                          String useruid = snapdata[index]["useruid"];
                          return Column(
                              children: [
                                InkWell(
                                  splashColor: Colors.grey,
                                  onTap: () {
                                    Get.toNamed(RouteServices.TESTIMONYDETAILSCREEN, arguments: [
                                      "${snapdata[index]["title"]}",
                                      "${snapdata[index]["testimonies"]}",
                                      "${snapdata[index]["timestamp"]}"
                                    ]);
                                  },
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: Dimensions.Height60+20,
                                        width: Dimensions.Width90-10,
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
                                            height: Dimensions.Height100,
                                            child: Padding(
                                              padding: EdgeInsets.only(left: Dimensions.Width2-1),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${snapdata[index]["title"]}",
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    height: Dimensions.Height2+1,
                                                  ),
                                                  Text(
                                                    "${snapdata[index]["testimonies"]}", maxLines: 2, overflow: TextOverflow.ellipsis,
                                                  ),
                                                  SizedBox(height: Dimensions.Height2+1,),
                                                  Text("${snapdata[index]["timestamp"]}"),
                                                  SizedBox(height: Dimensions.Height2+1,),
                                                  Row(
                                                    children: [
                                                      Wrap(
                                                          children: List.generate(5, (index) => Icon(Icons.star,
                                                            color: Colors.amberAccent,
                                                            size: Dimensions.Width16-1,
                                                          )
                                                          )
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )),
                                      PopupMenuButton(
                                        itemBuilder: (_) {
                                          return [const PopupMenuItem<String>(value: "delete", child: Text("Delete"))];
                                        },
                                        onSelected: (value) async {
                                          if (value == "delete") {
                                            await FirebaseFirestore.instance.runTransaction((Transaction myTransaction) async {
                                              myTransaction.delete(snapshot.data!.docs[index].reference);
                                            });
                                            Get.snackbar(
                                                "success",
                                                "Testimony has been deleted successfully",
                                                titleText: const Text("success", style: TextStyle(color: Colors.white),),
                                                messageText: const Text("Testimony has been deleted successfully",
                                                    style: TextStyle(color: Colors.white)),
                                                backgroundColor: Colors.orange,
                                                colorText: Colors.white
                                            );
                                          }
                                        },
                                        child: Icon(Icons.more_horiz, size: Dimensions.Width20+4,),
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: Dimensions.Height20,),
                              ]);
                        }),
                  ),
                ],
              ):Container(
                height: size.height,
                width: double.maxFinite,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const NoDataPage(text: 'You haven\'t testified yet',),
                    SizedBox(height: Dimensions.Height20,),
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteServices.CREATETESTIMONYSCREEN);
                      },
                      child: Container(
                        height: Dimensions.Height10*5,
                        width: Dimensions.Width100+50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(Dimensions.Width10),
                          color: Colors.orange
                        ),
                        child: Center(
                          child: Text("Testify",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: Dimensions.Width16
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }
            )
        ]
      )
    );
        }
}
