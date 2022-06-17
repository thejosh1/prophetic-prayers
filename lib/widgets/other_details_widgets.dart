import 'package:flutter/material.dart';

class OtherDetails extends StatelessWidget {
  const OtherDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buildButton(context, 'streaks', '2'),
          buildDivider(),
          buildButton(context, 'weeks', '32'),
        ],
      ),
    );
  }

  Widget buildDivider() => Container(
    height: 24,
    child: VerticalDivider(
      color: Colors.black,
    ),
  );

  Widget buildButton(BuildContext context, String text, String value) {
   return MaterialButton(
     padding: EdgeInsets.symmetric(vertical: 4),
      onPressed: (){

      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          SizedBox(height: 2,),
          Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }
}
