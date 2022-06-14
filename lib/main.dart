import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/auth_pages/sign_up.dart';
import 'package:prophetic_prayers/pages/prayer_category_screen.dart';
import 'package:prophetic_prayers/pages/prayer_list.dart';
import 'package:prophetic_prayers/pages/prayer_list_screen.dart';
import 'package:prophetic_prayers/pages/prayer_screen.dart';
import 'package:prophetic_prayers/pages/testimony_screen.dart';
import 'package:prophetic_prayers/pages/welcome.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Poppins'
        ),

        home:  TestimonyScreen()
    );
  }
}

