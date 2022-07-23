import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ScrollToHideWidget extends StatefulWidget {
  final Widget child;
  final ScrollController controller;
  final Duration duration;

  const ScrollToHideWidget({Key? key, required this.child, required this.controller, this.duration = const Duration(milliseconds: 200), required height,}) : super(key: key);

  @override
  _ScrollToHideWidgetState  createState() => _ScrollToHideWidgetState();
}

class _ScrollToHideWidgetState extends State<ScrollToHideWidget> {
  bool isVisible = true;

  @override initState(){
    super.initState();
    widget.controller.addListener(listen);
  }

  @override dispose () {
    widget.controller.removeListener(listen);
    super.dispose();
  }

  void listen () {
    final direction = widget.controller.position.userScrollDirection;
    if(direction == ScrollDirection.forward) {
      show();
    } else if(direction == ScrollDirection.reverse) {
      hide();
    }
  }

  void show() {
    if(!isVisible) setState(() => isVisible = true);
  }

  void hide () {
    if(isVisible) setState(() => isVisible = false);
  }

  @override
  Widget build(BuildContext context) => AnimatedContainer(
      duration: widget.duration,
      child: Wrap(
        children: [
          widget.child,
        ],
      ),
      height: isVisible ? kBottomNavigationBarHeight : 0,
  );
}