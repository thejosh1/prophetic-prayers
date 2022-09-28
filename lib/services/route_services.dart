import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/create_testimony_screen.dart';
import 'package:prophetic_prayers/pages/auth_pages/edit_screen.dart';
import 'package:prophetic_prayers/pages/main_page.dart';
import 'package:prophetic_prayers/pages/other_detail_screen.dart';
import 'package:prophetic_prayers/pages/prayer_detail_screen.dart';
import 'package:prophetic_prayers/pages/screens/academy_screen.dart';
import 'package:prophetic_prayers/pages/screens/blessings_screen.dart';
import 'package:prophetic_prayers/pages/screens/calling_screen.dart';
import 'package:prophetic_prayers/pages/screens/discipline_screen.dart';
import 'package:prophetic_prayers/pages/screens/prayer_screen.dart';
import 'package:prophetic_prayers/pages/testimony_detail_page.dart';

import '../pages/about_screen.dart';
import '../pages/plan_list.dart';
import '../pages/prayer_list_screen.dart';
import '../pages/screens/career_screen.dart';
import '../pages/screens/health_screen.dart';
import '../pages/screens/lifestyle_screen.dart';
import '../pages/screens/warfare_screen.dart';
import '../pages/splash_screen.dart';

class RouteServices {
  static const SPLASHSCREEN = "/splash-screen";
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
  static const EDITPROFILESCREEN = "/edit-profile-screen";
  static const OTHERDETAILSCREEN = "/other-detail-screen";
  static const ABOUTSCREEN = "/about-screen";
  static const PRAYERLISTSCREEN = "/prayer-list-screen";
  static const PLANLISTSCREEN = "/plan-list-screen";

  static String getSplashScreen() => "$SPLASHSCREEN";
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
  static String geteditProfileScreen() => "$EDITPROFILESCREEN";
  static String getotherDetailScreen() => "$OTHERDETAILSCREEN";
  static String getaboutScreen() => "$ABOUTSCREEN";
  static String getprayerListScreen() => "$PRAYERLISTSCREEN";
  static String getplanListScreen()=> "$PLANLISTSCREEN";

  static List<GetPage> routes = [
    GetPage(name: SPLASHSCREEN, page: ()=>const SplashScreen()),
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
    GetPage(name: EDITPROFILESCREEN, page: () => const EditScreen(), transition: Transition.fadeIn),
    GetPage(name: OTHERDETAILSCREEN, page: () => const OtherDetailScreen(), transition: Transition.fadeIn),
    GetPage(name: ABOUTSCREEN, page: () => const AboutScreen(), transition: Transition.fadeIn),
    GetPage(name: PRAYERLISTSCREEN, page: () => const PrayerListScreen(), transition: Transition.fadeIn),
    GetPage(name: PLANLISTSCREEN, page:  () => const PlanListScreen(), transition: Transition.fadeIn),
  ];
}