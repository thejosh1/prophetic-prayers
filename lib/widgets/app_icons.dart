import 'package:flutter/material.dart';

class AppIcons extends StatelessWidget {
  final IconData icon;
  final Color backgroundColor;
  final Color iconcolor;
  final double size;
  final double iconSize;

  const AppIcons({Key? key, required this.icon, this.backgroundColor = const Color(0xFFfcf4e4), this.iconcolor = const Color(0xFF756d54), this.size=40, this.iconSize=16}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(size/2),
          color: backgroundColor
      ),
      child: Icon(
        icon,
        color: iconcolor,
        size: iconSize,
      ),
    );
  }
}