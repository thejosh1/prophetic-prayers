import 'package:flutter/material.dart';
import 'package:prophetic_prayers/pages/prayer_list_screen.dart';
import 'package:prophetic_prayers/pages/prayer_screen.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final controller = PageController(initialPage: 0);

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
      body: Container(
        child: PageView(
          controller: controller,
          children: const [
            PrayerScreen(),
            PrayerListScreen(),
          ],
        ),
      )
    );
  }
}
