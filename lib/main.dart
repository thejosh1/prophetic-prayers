import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/controller/auth_controller.dart';
import 'package:prophetic_prayers/pages/main_page.dart';
import 'package:prophetic_prayers/pages/welcome.dart';
import 'package:prophetic_prayers/services/notify_services.dart';
import 'package:prophetic_prayers/services/route_services.dart';
import 'package:prophetic_prayers/utils/shared_preferences.dart';

import 'controller/scripture_controller.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotifyServices.init(initScheduled: true);
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  //AuthController.instance.Logout();
  NotifyServices.showScheduledDailyNotification(
      title: "Reminder",
      body: "Prophetic Prayers for children live",
      payload: "$WelcomeScreen",
      scheduledDate: DateTime.now());
  NotifyServices.showScheduledWeeklyNotification(
      title: "Reminder",
      body: "Prohetic Prayers for children is live",
      payload: "$WelcomeScreen",
      scheduledDate: DateTime.now());

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  await AppPreferences.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        title: 'Prophetic Prayers',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue,
            fontFamily: 'Poppins',
        ),
        initialRoute: RouteServices.INITIAL,
        getPages: RouteServices.routes
    );
  }
}



