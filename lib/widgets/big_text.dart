import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  const BigText({Key? key, required this.text, this.size = 24, this.color = const Color(0xFF1E2432)}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          fontSize: size,
          fontWeight: FontWeight.w800,
          fontFamily: 'Poppins'
      ),
    );
  }
}
