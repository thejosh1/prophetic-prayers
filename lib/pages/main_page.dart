import 'package:flutter/material.dart';
import 'package:prophetic_prayers/pages/prayer_category_screen.dart';
import 'package:prophetic_prayers/pages/profile_page.dart';
import 'package:prophetic_prayers/pages/discover_screen.dart';
import 'package:prophetic_prayers/pages/testimonies_screen.dart';
import 'package:prophetic_prayers/pages/testimony_detail_page.dart';
import 'package:prophetic_prayers/pages/welcome.dart';

import '../widgets/scroll_to_hide_widget.dart';

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
    const DiscoverScreen(),
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
          selectedFontSize: 0,
          unselectedFontSize: 0,
          onTap: onTap,
          currentIndex: currentIndex,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey.withOpacity(0.5),
          showSelectedLabels: true,
          showUnselectedLabels: false,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.bar_chart_sharp), label: "My plans",),
            BottomNavigationBarItem(
                icon: Icon(Icons.list_sharp), label: "Testimonies"),
            BottomNavigationBarItem(
                icon: Icon(Icons.search), label: "Discover",),
            BottomNavigationBarItem(
              icon: Icon(Icons.person), label: "My page", )
          ],
        ),
      ),
    );
  }

}