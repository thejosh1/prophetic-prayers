import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/controller/auth_controller.dart';
import 'package:prophetic_prayers/pages/main_screen/welcome.dart';
import 'package:prophetic_prayers/services/notify_services.dart';
import 'package:prophetic_prayers/services/route_services.dart';
import 'package:prophetic_prayers/utils/shared_preferences.dart';


final navigatorKey = GlobalKey<NavigatorState>();
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await NotifyServices.init(initScheduled: true);
  await Firebase.initializeApp().then((value) => Get.put(AuthController()));
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  //await FirebaseAppCheck.instance.activate();
  //AuthController.instance.Logout();
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



class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  String notificationmsg = "Waiting for notification";
  @override
  void initState() {
    super.initState();
    initDynamicLink();
    FirebaseMessaging.instance.getInitialMessage().then((event) {
      if(event != null) {
        final routeFromMessage = event.data["route"];
        Get.toNamed(routeFromMessage);
      }
    });
    //when the app is in foreground
    FirebaseMessaging.onMessage.listen((event) {
      if(event.notification != null) {
        NotifyServices.displayNotification(event);
      }
    });
    //when the app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      final routeFromMessage = event.data["route"];
      Get.toNamed(routeFromMessage);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        navigatorKey: navigatorKey,
        title: 'Prophetic Prayers',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.deepPurple,
            fontFamily: 'Poppins',
        ),
         //initialRoute: RouteServices.SPLASHSCREEN,
        getPages: RouteServices.routes
    );
  }
  void initDynamicLink() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamiclink) async {
          final Uri? deeplink = dynamiclink?.link;

          if(deeplink != null) {
            Get.toNamed(deeplink.queryParameters.values.first);
            //print("deep link "+deeplink.toString());
          }
        },
        onError: (OnLinkErrorException e) async {
          print(e.message);
        }
    );
  }
}




