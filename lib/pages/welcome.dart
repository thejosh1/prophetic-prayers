import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 80),
            Image.asset(
              'images/welcome.png',
              width: size.width,
            ),
            SizedBox(height: 57),
            Text(
              'It has survived not only five centuries, but also',
              style: TextStyle(
                fontSize: 24,

                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            Text(
              ''' It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.
              It was popularised in the 1960s with the release of Letraset sheets co''',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xffBEC2CE),
              ),

              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
