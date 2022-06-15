import 'package:flutter/material.dart';
import 'package:prophetic_prayers/utils/user_preference.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget (
            imagePath: user.imagePath,
            onClicked: () async {
              
            }
          )
        ],
      ),
    );
  }
}

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({Key? key, required this.imagePath, required this.onClicked}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: buildImage(),
    );
  }

  Widget buildImage() {
    final image = NetworkImage(imagePath);
    
    return Ink.image(
      image: image,
      fit: BoxFit.cover,
      width: 120,
      height: 120,
    );
  }



}
