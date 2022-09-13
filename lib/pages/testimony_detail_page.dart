import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prophetic_prayers/services/route_services.dart';

class TestimonyDetailPage extends StatelessWidget {
  const TestimonyDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var data = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(),
      body: Container(
        margin: EdgeInsets.only(left: 20, right: 20, top: 21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Text(data[2], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w200, color: Colors.grey),),
                ),
                Container(
                  width: 154,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Color(0xFF515BDE), width: 1.5),
                  ),
                  child: GestureDetector(
                    onTap: (){
                      Get.toNamed(RouteServices.CREATETESTIMONYSCREEN);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Icon(
                          Icons.note_add,
                          color: Color(0xFF515BDE),
                        ),
                        Text("Have a testimony?")
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 25,),
            Text(data[0], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
            Text(data[1],textAlign: TextAlign.left,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 16),)
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
    // TODO: implement build
    return Container(
      color: const Color(0xffF7F8FA),
      padding: const EdgeInsets.only(left: 24, right: 24, top: 46),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: const Icon(Icons.arrow_back_outlined)),
              const Icon(Icons.more_vert),
            ],
          ),
          const SizedBox(height: 21),
          const Text(
            'Testimony',
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
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(126);
}
