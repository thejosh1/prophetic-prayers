import 'package:flutter/material.dart';

import '../utils/dimensions.dart';
import 'app_icons.dart';
import 'big_text.dart';

class ProfileWidget extends StatelessWidget {
  AppIcons appIcons;
  BigText bigText;
  
  ProfileWidget({Key? key, required this.appIcons, required this.bigText}) : super(key:key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Dimensions.Height100-40,
      margin: EdgeInsets.only(top: Dimensions.Height10, bottom: Dimensions.Height10, left: Dimensions.Width10, right: Dimensions.Width10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.Width30/2),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            blurRadius: 1,
            offset: const Offset(0, 2),
            color: Colors.grey.withOpacity(0.2)
          )
        ]
      ),
      child: Row(
        children: <Widget>[
          SizedBox(width: Dimensions.Width10,),
          appIcons,
          SizedBox(width: Dimensions.Width10,),
          bigText
        ],
      ),
    );
  }
  
  
}