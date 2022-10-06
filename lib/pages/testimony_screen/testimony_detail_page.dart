import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prophetic_prayers/services/route_services.dart';

import '../../utils/dimensions.dart';

class TestimonyDetailPage extends StatelessWidget {
  const TestimonyDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(),
      body: Container(
        margin: EdgeInsets.only(left: Dimensions.Width20, right: Dimensions.Width20, top: Dimensions.Height20+1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(data[2], style: TextStyle(fontSize: Dimensions.Width16, fontWeight: FontWeight.w200, color: Colors.grey),),
                ),
                Container(
                  width: Dimensions.Width150+4,
                  height: Dimensions.Height20+8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.Width20),
                    border: Border.all(color: Colors.orange, width: Dimensions.Width2-0.5),
                  ),
                  child: GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteServices.CREATETESTIMONYSCREEN);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.edit,
                          color: Colors.orange,
                        ),
                        Text("Have a testimony?")
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: Dimensions.Height20+5,),
            //Text(data[0], style: TextStyle(fontWeight: FontWeight.bold, fontSize: Dimensions.Width20+4),),
            Text(data[1],textAlign: TextAlign.left,
            style:  TextStyle(fontWeight: FontWeight.w400, fontSize: Dimensions.Width16),)
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
    var data = Get.arguments;
    // TODO: implement build
    return Container(
      color: const Color(0xffF7F8FA),
      padding: EdgeInsets.only(left: Dimensions.Width20+4, right: Dimensions.Width20+4, top: Dimensions.Height40+6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: (){
                Get.back();
              },
              child: const Icon(Icons.arrow_back_outlined)),
          SizedBox(height: Dimensions.Height20+1),
          Text(
            data[0],
            style: TextStyle(
              fontSize: Dimensions.Width30+4,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(Dimensions.Height100+26);
}
