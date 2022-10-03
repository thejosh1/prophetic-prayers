import 'package:flutter/material.dart';


import '../../utils/dimensions.dart';


class AboutScreen extends StatefulWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.height,
          margin: EdgeInsets.only(top: Dimensions.height22),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "images/about_image.jpeg",
                  ), fit: BoxFit.cover
              )
          ),
        ),
      )
    );
  }
}
