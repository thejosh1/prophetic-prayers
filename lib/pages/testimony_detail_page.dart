import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prophetic_prayers/pages/create_testimony_screen.dart';

class TestimonyDetailPage extends StatelessWidget {
  const TestimonyDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    width: 150,
                    child: Text("Anonymous", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),)
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
                      Get.to(()=> const CreateTestimonyScreen());
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.note_add,
                          color: Color(0xFF515BDE),
                        ),
                        Text("have a testimony?")
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 25,),
            Text(textAlign: TextAlign.left,"Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Morbi tristique senectus et netus. Hendrerit gravida rutrum quisque non. Id neque aliquam vestibulum morbi blandit. Sollicitudin nibh sit amet commodo nulla facilisi nullam vehicula ipsum. Ultrices mi tempus imperdiet nulla. Et sollicitudin ac orci phasellus egestas tellus rutrum tellus pellentesque. Et netus et malesuada fames ac turpis egestas. Suspendisse ultrices gravida dictum fusce. Pharetra sit amet aliquam id diam maecenas ultricies mi. Urna id volutpat lacus laoreet non curabitur gravida.",
            style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),)
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
