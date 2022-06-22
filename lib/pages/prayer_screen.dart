import 'package:flutter/material.dart';
import 'package:prophetic_prayers/pages/prayer_list.dart';
import 'package:prophetic_prayers/utils/dimensions.dart';

import '../services/notify_services.dart';
import '../widgets/big_text.dart';

class PrayerScreen extends StatefulWidget {
  const PrayerScreen({Key? key}) : super(key: key);

  @override
  State<PrayerScreen> createState() => _PrayerScreenState();
}

class _PrayerScreenState extends State<PrayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: Dimensions.pageScreenMainContainerWidth13, right: Dimensions.pageScreenMainContainerWidth13, top: Dimensions.pageScreenMainContainerHeight46),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            height: Dimensions.pageScreenExpandedContainerHeight40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(Dimensions.pageScreenExpandedRadiusHeight10),
                              color: const Color(0xFFEDEEF0),
                            ),
                            padding: EdgeInsets.only(
                                left: Dimensions.pageScreenExpandedPaddingWidth20, right: Dimensions.pageScreenExpandedPaddingWidth12, top: Dimensions.pageScreenExpandedPaddingHeight10),
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
                        SizedBox(width: Dimensions.pageScreenSizedBoxWidth17),
                        const CircleAvatar(
                            //Logo should be here
                            backgroundImage: AssetImage("images/gracious-adebayo.jpg")),
                      ],
                    ),
                    SizedBox(height: Dimensions.pageScreenSizedBoxHeight12),
                    const BigText(text: "Welcome"),
                    SizedBox(height: Dimensions.pageScreenSizedBoxHeight16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: const [Icon(Icons.bookmark)],
                    ),
                    SizedBox(height: Dimensions.pageScreenExpandedRadiusHeight10),
                  ],
                ),
              ),
              const PrayerList(),
            ],
          ),
        ),
      ),
    );
  }
}
