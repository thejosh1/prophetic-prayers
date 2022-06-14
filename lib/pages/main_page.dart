import 'package:flutter/material.dart';
import 'package:prophetic_prayers/pages/prayer_category_screen.dart';
import 'package:prophetic_prayers/pages/prayer_screen.dart';
import 'package:prophetic_prayers/pages/profile_page.dart';
import 'package:prophetic_prayers/pages/testimony_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List pages = [
    const PrayerScreen(),
    const PrayerCategoryScreen(),
    const TestimonyScreen(),
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
      backgroundColor: Colors.white,
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        unselectedFontSize: 0,
        onTap: onTap,
        currentIndex: currentIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.apps), label: "Prayer Categories"),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_online), label: "Testimonies"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "My page")
        ],
      ),
    );
  }
}
