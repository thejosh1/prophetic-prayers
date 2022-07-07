import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;
  
  const ProfileWidget({Key? key, required this.imagePath, required this.onClicked}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;

    return Center(
      child: Stack(
          children: [
            buildImage(),
            Positioned(
              bottom: 0,
              right: 4,
              child: buildEditButton(color)
            ),
          ]
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
          width: 200,
          height: 200,
          child: InkWell(onTap: onClicked,),
        ),
      ),
    );
  }

  Widget buildEditButton(Color color) {
    return buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
        color: color,
        all: 16.0,
        child: Icon(
          Icons.edit,
          size: 20,
          color: Colors.white,)
      ),
    );
  }

  Widget buildCircle({required Color color, required double all, required Widget child}) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
  }
  
  
}