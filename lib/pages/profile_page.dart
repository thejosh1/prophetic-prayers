import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:prophetic_prayers/utils/user_preference.dart';
import '../models/users.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      appBar: MyAppBar(),
      backgroundColor: Colors.white,
      body: Container(
        margin: EdgeInsets.only(top: 30),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ProfileWidget (
              imagePath: user.imagePath,
              onClicked: () async {

              }
            ),
            SizedBox(height: 24,),
            buildName(user),
            SizedBox(height: 24,),
            OtherDetails(),
          ],
        ),
      ),
    );
  }

  buildName(User user) => Column(
    children: [
      Text(user.name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),),
      SizedBox(height: 4,),
      Text(user.phonenumber, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),),
      SizedBox(height: 4,),
      Text(user.email, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.grey),)
    ],
  );
}

class OtherDetails {
}

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({Key? key, required this.imagePath, required this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          buildImage(),
          Positioned(
              bottom: 0,
              right: 4,
              child: buildEditIcon(Colors.black)
          ),
        ],
      ),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);
    
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 120,
          height: 120,
          child: InkWell(onTap: onClicked,),
        ),
      ),
    );
  }

  Widget buildEditIcon(Color color) => buildCircle(
    all: 3,
    color: Colors.white,
    child: buildCircle(
      color: color,
      all: 8,
      child: Icon(
        Icons.edit,
        color: Colors.white,
        size: 20,
      ),
    ),
  );

  Widget buildCircle({required Widget child, required double all, required Color color}) => ClipOval(
    child: Container(
      child: child,
      color: color,
      padding: EdgeInsets.all(all),
    ),
  );

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
              const Icon(Icons.more_vert),
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
