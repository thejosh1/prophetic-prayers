import 'package:flutter/material.dart';
import 'package:prophetic_prayers/pages/main_screen/prayer_category_screen.dart';
import 'package:prophetic_prayers/pages/auth_pages/profile_page.dart';
import 'package:prophetic_prayers/pages/testimony_screen/testimonies_screen.dart';
import 'package:prophetic_prayers/pages/main_screen/welcome.dart';

import '../../widgets/scroll_to_hide_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late ScrollController controller;

  @override
  void initState(){
    super.initState();

    controller = ScrollController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List pages = [
    const WelcomeScreen(),
    const PrayerCategoryScreen(),
    const TestimoniesScreen(),
    const ProfilePage()
  ];

  int currentIndex = 0;
  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: pages[currentIndex],
      bottomNavigationBar: ScrollToHideWidget(
        controller: controller,
        height: 80,
        child: BottomNavigationBar(
          backgroundColor: Colors.red,
          unselectedFontSize: 0,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: const Color(0xff515BDE),
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          elevation: 0,
          items: const<BottomNavigationBarItem> [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.apps), label: "My plans",),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_sharp), label: "Testimonies"),
            BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "My page", )
          ],
        ),
      ),
    );
  }

}