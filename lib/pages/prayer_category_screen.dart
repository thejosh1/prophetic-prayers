import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/auth_pages/sign_up.dart';
import 'package:prophetic_prayers/pages/prayer_list_screen.dart';

class PrayerCategoryScreen extends StatelessWidget {
  const PrayerCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: MyAppBar(),
      body: Container(
        margin: EdgeInsets.only(left: 16, right: 1.5, top: 21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Choose Categories", style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),),
            SizedBox(height: 25,),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>PrayerListScreen());
                      },
                      child: Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          image: DecorationImage(
                            image: AssetImage(
                              "images/adrianna-geo.jpg"
                            ),fit: BoxFit.cover
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 13,),
                    Text("Children", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    SizedBox(height: 2,),
                    //Text("", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFFC2C4CA)),)
                  ],
                ),
                SizedBox(width: 18,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                            image: AssetImage(
                                "images/jon-tyson.jpg"
                            ),fit: BoxFit.cover
                        ),
                      ),
                    ),
                    SizedBox(height: 13,),
                    Text("Prosperity", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    SizedBox(height: 2,),
                    //Text("Austria", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFFC2C4CA)),)
                  ],
                ),
              ],
            ),
            SizedBox(height: 19,),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                            image: AssetImage(
                                "images/ismael-paramo.jpg"
                            ),fit: BoxFit.cover
                        ),
                      ),
                    ),
                    SizedBox(height: 13,),
                    Text("Marriage", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    SizedBox(height: 2,),
                    //Text("Romania", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFFC2C4CA)),)
                  ],
                ),
                SizedBox(width: 18,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                            image: AssetImage(
                                "images/diana-simum.jpg"
                            ),fit: BoxFit.cover
                        ),
                      ),
                    ),
                    SizedBox(height: 13,),
                    Text("Business", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                    SizedBox(height: 2,),
                    //Text("Bulgaria", style: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: Color(0xFFC2C4CA)),)
                  ],
                ),
              ],
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
              const Icon(Icons.arrow_back_outlined),
              const Icon(Icons.more_vert),
            ],
          ),
          const SizedBox(height: 21),
          const Text(
            'Categories',
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
