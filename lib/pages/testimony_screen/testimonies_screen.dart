import 'package:basic_utils/basic_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/services/route_services.dart';
import 'package:prophetic_prayers/widgets/big_text.dart';
import '../../controller/auth_controller.dart';
import '../../utils/dimensions.dart';

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
      backgroundColor: const Color(0xffF7F8FA),
      appBar: const MyAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: Dimensions.Height20,
            ),
            Container(
              margin: EdgeInsets.only(left: Dimensions.Width20, right: Dimensions.Width6),
              child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection("testimonies").snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(!snapshot.hasData) {
                      return const Center(child: Text("No testimonies yet be the first to testify"),);
                    }
                    List snapdata = snapshot.data!.docs;
                    return snapdata.isNotEmpty ? SingleChildScrollView(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Testimonies",
                                    style: TextStyle(
                                        fontSize: Dimensions.Width16-2,
                                        fontWeight: FontWeight.w800,
                                        color: const Color(0xFF1E2432)),
                                  ),
                                  SizedBox(
                                    width: Dimensions.Width2,
                                  ),
                                  Container(
                                    height: Dimensions.Height20+7,
                                    width: Dimensions.Width20+7,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(Dimensions.Width6+2),
                                        color: const Color(0xFFE2952A)),
                                    child: Center(
                                      child: Text(
                                        "${int.parse(snapdata.length.toString())}",
                                        style: TextStyle(
                                            fontSize: Dimensions.Width16-2,
                                            fontWeight: FontWeight.w800,
                                            color: const Color(0xFF1E2432)),
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
                                  width: Dimensions.Width150+4,
                                  height: Dimensions.Height20+8,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(Dimensions.Width20),
                                    border: Border.all(color: Colors.orange),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Icon(
                                        Icons.edit,
                                        color: Colors.orange,
                                      ),
                                      Text("Testify")
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: Dimensions.Height20+10,),
                          Container(
                            height: double.maxFinite,
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
                                          onTap: (){
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
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(Dimensions.Width20),
                                                    border: Border.all(color: Colors.grey, width: Dimensions.Width2),
                                                    color: Colors.white
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
                                                            style: TextStyle(
                                                                fontWeight: FontWeight.bold, fontSize: Dimensions.Width20+4, color: Colors.black))
                                                    );
                                                  },
                                                ),

                                              ),
                                              Expanded(
                                                  child: Container(
                                                    height: Dimensions.Height100,
                                                    child: Padding(
                                                      padding: EdgeInsets.only(left: Dimensions.Width10),
                                                      child: Column(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(StringUtils.capitalize("${snapdata[index]["title"]}"),
                                                            maxLines: 1,
                                                            overflow: TextOverflow.ellipsis, style: const TextStyle(fontWeight: FontWeight.bold),),
                                                          SizedBox(height: Dimensions.Height2+1,),
                                                          Text(StringUtils.capitalize("${snapdata[index]["testimonies"]}"), maxLines: 2, overflow: TextOverflow.ellipsis,),
                                                          SizedBox(height: Dimensions.Height2+1,),
                                                          Text("${snapdata[index]["timestamp"]}"),
                                                          SizedBox(height: Dimensions.Height2+1,),
                                                          Row(
                                                            children: [
                                                              Wrap(children:
                                                              List.generate(5, (index) => Icon(
                                                                Icons.star, color: Colors.amberAccent,
                                                                size: Dimensions.Width16-1,))
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
                                        SizedBox(height: Dimensions.Height20,),
                                      ]
                                  );
                                }),
                          ),
                        ],
                      ),
                    ): Column(
                      children: [
                        SizedBox(height: Dimensions.Height270,),
                        Text("No testimonies yet be the first to testify", style: TextStyle(fontSize: Dimensions.Width16+2, color: Colors.black54,))
                      ],
                    );
                  }),
            )
          ],
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
      height: Dimensions.Height100,
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
      padding: EdgeInsets.only(left: Dimensions.Width20+4, right: Dimensions.Width20+4, top: Dimensions.Height40+6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          FutureBuilder(
              future: FirebaseFirestore.instance.collection("users").doc(user?.uid).get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Welcome", style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.Width20+4,));
                } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!.exists) {
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return Text("Welcome ${data["name"]}", style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.Width16+2),);
                }
                return Text("Welcome", style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.Width16+2),);
              }
          ),
          FutureBuilder(
              future: FirebaseFirestore.instance.collection("users").doc(user?.uid).get(),
              builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: Dimensions.Height20+10,
                    width: Dimensions.Width30,
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: AssetImage("images/app_logo.png")
                        )
                    ),
                  );
                } else if(snapshot.connectionState == ConnectionState.done && snapshot.hasData && snapshot.data!.exists) {
                  Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
                  return Container(
                    height: Dimensions.Height20+10,
                    width: Dimensions.Width30,
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
                  height: Dimensions.Height20+10,
                  width: Dimensions.Width30,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage("images/app_logo.png")
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
  Size get preferredSize => Size.fromHeight(Dimensions.Height100+26);
}
