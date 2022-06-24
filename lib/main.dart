import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/data/database_helper.dart';
import 'package:prophetic_prayers/pages/main_page.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper;

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
            fontFamily: 'Poppins',
        ),
        initialRoute: "/",
        getPages: [
          GetPage(name: "/", page: ()=> const MainPage()),
        ],
    );
  }
}



