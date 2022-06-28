import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/data/database_helper.dart';
import 'package:prophetic_prayers/pages/main_page.dart';
import 'package:prophetic_prayers/services/notify_services.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotifyServices.init(initScheduled: true);
  NotifyServices.showScheduledDailyNotification(
      title: "a reminder",
      body: "my reminder",
      payload: "",
      scheduledDate: DateTime.now());
  NotifyServices.showScheduledWeeklyNotification(scheduledDate: DateTime.now());


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



