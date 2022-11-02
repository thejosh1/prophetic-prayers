import 'package:flutter/material.dart';
import '../utils/dimensions.dart';

class CustomLoader extends StatefulWidget {
  const CustomLoader({Key? key}) : super(key: key);

  @override
  State<CustomLoader> createState() => _CustomLoaderState();
}

class _CustomLoaderState extends State<CustomLoader> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  
  
  @override
  initState() {
    super.initState();
    controller = AnimationController(vsync: this, duration: const Duration(seconds: 2));
    animation = Tween(begin: 0.0, end: 1.0,).animate(controller);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    controller.forward();

    return FadeTransition(
      opacity: animation,
      child: Image.asset("images/man-moving.jpg", height: Dimensions.splashimg, width: Dimensions.splashimg,),
    );
  }
}
