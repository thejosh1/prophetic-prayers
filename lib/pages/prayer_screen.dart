import 'package:flutter/material.dart';
import 'package:prophetic_prayers/pages/prayer_list.dart';

import '../widgets/big_text.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({Key? key}) : super(key: key);

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(left: 13, right: 13, top: 46),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFEDEEF0),
                            ),
                            padding: const EdgeInsets.only(
                                left: 20, right: 12, top: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Expanded(
                                  child: TextField(
                                    decoration: InputDecoration.collapsed(
                                      hintText: "Search",
                                      hintStyle: TextStyle(
                                        color: Color(0xffBEC2CE),
                                      ),
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.search_outlined,
                                  color: Colors.grey,
                                )
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 17),
                        CircleAvatar(
                            backgroundImage: AssetImage("images/gracious-adebayo.jpg")),
                      ],
                    ),
                    SizedBox(height: 12),
                    BigText(text: "Good Morning Josh"),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [Icon(Icons.bookmark)],
                    ),
                    SizedBox(height: 10),
                  ],
                ),
              ),
              PrayerList(),
            ],
          ),
        ),
      ),
    );
  }
}
