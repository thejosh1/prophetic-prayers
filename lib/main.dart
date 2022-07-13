import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/controller/auth_controller.dart';
import 'package:prophetic_prayers/pages/main_page.dart';
import 'package:prophetic_prayers/pages/welcome.dart';
import 'package:prophetic_prayers/pages/prayer_screen.dart';
import 'package:prophetic_prayers/services/notify_services.dart';


Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotifyServices.init(initScheduled: true);
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  AuthController.instance.Logout();
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



