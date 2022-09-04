import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/create_testimony_screen.dart';
import 'package:prophetic_prayers/pages/main_page.dart';
import 'package:prophetic_prayers/pages/prayer_detail_screen.dart';
import 'package:prophetic_prayers/pages/screens/academy_screen.dart';
import 'package:prophetic_prayers/pages/screens/blessings_screen.dart';
import 'package:prophetic_prayers/pages/screens/calling_screen.dart';
import 'package:prophetic_prayers/pages/screens/discipline_screen.dart';
import 'package:prophetic_prayers/pages/screens/prosperity_screen.dart';
import 'package:prophetic_prayers/pages/testimony_detail_page.dart';

import '../pages/screens/career_screen.dart';
import '../pages/screens/health_screen.dart';
import '../pages/screens/lifestyle_screen.dart';
import '../pages/screens/warfare_screen.dart';

class RouteServices {
  static const INITIAL = "/";
  static const PRAYERDETAIL = "/prayer-details";
  static const PROSPERITYSCRIPTURESCREEN = "/prosperity-scripture-screen";
  static const ACADEMYSCRIPTURESCREEN = "/academy-scripture-screen";
  static const BLESSINGSCRIPTURESCREEN = "/blessing-scripture-screen";
  static const CALLINGSCRIPTURESCREEN = "/calling-scripture-screen";
  static const CAREERSCRIPTURESCREEN = "/career-scripture-screen";
  static const DISCIPLINESCRIPTURESCREEN = "/discipline-scripture-screen";
  static const HEALTHSCRIPTURESCREEN = "/health-scripture-screen";
  static const LIFESTYLESCRIPTURESCREEN = "/lifestyle-scripture-screen";
  static const MARRIAGESCRIPTURESCREEN = "/marriage-scripture-screen";
  static const WARFARESCRIPTURESCREEN = "/warfare-scripture-screen";
  static const TESTIMONYDETAILSCREEN = "/testimony-detail-screen";
  static const CREATETESTIMONYSCREEN = "/create-testimony-screen";
  static String getInitial() => "$INITIAL";
  static String getPrayerDetailScreen() => "$PRAYERDETAIL";
  static String getProsperityScriptureScreen() => "$PROSPERITYSCRIPTURESCREEN";
  static String getacademyScriptureScreen() => "$ACADEMYSCRIPTURESCREEN";
  static String getblessingScriptureScreen() => "$BLESSINGSCRIPTURESCREEN";
  static String getcallingScriptureScreen() => "$CALLINGSCRIPTURESCREEN";
  static String getcareerScriptureScreen() => "$CAREERSCRIPTURESCREEN";
  static String getdisciplineScriptureScreen() => "$DISCIPLINESCRIPTURESCREEN";
  static String gethealthScriptureScreen() => "$HEALTHSCRIPTURESCREEN";
  static String getlifestyleScriptureScreen() => "$LIFESTYLESCRIPTURESCREEN";
  static String getmarriageScriptureScreen() => "$MARRIAGESCRIPTURESCREEN";
  static String getwarfareScriptureScreen() => "$WARFARESCRIPTURESCREEN";
  static String gettestimonyDetailScreen() => "$TESTIMONYDETAILSCREEN";
  static String getcreateTestimonyScreen() => "$CREATETESTIMONYSCREEN";

  static List<GetPage> routes = [
    GetPage(name: INITIAL, page: ()=> const MainPage()),
    GetPage(name: PRAYERDETAIL, page: ()=> const PrayerDetailScreen(), transition: Transition.fadeIn),
    GetPage(name: PROSPERITYSCRIPTURESCREEN, page: ()=> const PrayerScreen(), transition: Transition.fadeIn),
    GetPage(name: ACADEMYSCRIPTURESCREEN, page: ()=> const AcademyScreen(), transition: Transition.fadeIn),
    GetPage(name: BLESSINGSCRIPTURESCREEN, page: ()=> const BlessingsScreen(), transition: Transition.fadeIn),
    GetPage(name: CALLINGSCRIPTURESCREEN, page: ()=> const CallingScreen(), transition: Transition.fadeIn),
    GetPage(name: CAREERSCRIPTURESCREEN, page: ()=> const CareerScreen(), transition: Transition.fadeIn),
    GetPage(name: DISCIPLINESCRIPTURESCREEN, page: ()=> const DisciplineScreen(), transition: Transition.fadeIn),
    GetPage(name: HEALTHSCRIPTURESCREEN, page: ()=> const HealthScreen(), transition: Transition.fadeIn),
    GetPage(name: LIFESTYLESCRIPTURESCREEN, page: ()=> const LifeStyleScreen(), transition: Transition.fadeIn),
    GetPage(name: WARFARESCRIPTURESCREEN, page: ()=> const WarfareScreen(), transition: Transition.fadeIn),
    GetPage(name: TESTIMONYDETAILSCREEN, page: () => const TestimonyDetailPage(), transition: Transition.fadeIn),
    GetPage(name: CREATETESTIMONYSCREEN, page: () => const CreateTestimonyScreen(), transition: Transition.fadeIn),
  ];
}