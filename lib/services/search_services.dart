import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prophetic_prayers/controller/scripture_controller.dart';
import 'package:prophetic_prayers/models/prayers.dart';
import 'package:get/get.dart';
import 'package:prophetic_prayers/pages/prayer_detail_screen.dart';

import '../utils/dimensions.dart';

class SearchServices extends SearchDelegate<Scripture>{
  final Scripture scripture;

  SearchServices(this.scripture);
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(onPressed: (){
        query = '';
      }, icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(onPressed: (){
      close(context, scripture);
    }, icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    var _selectedImage = images[Random().nextInt(images.length)];
    return FutureBuilder(
        future: readJson(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Center(child: Text("no data"),);
          }
          final result = snapshot.data as List<Scripture>;
          final results = result.where((element) => element.date.toString().toLowerCase().contains(query.toLowerCase()));
          return ListView(
            children: results.map<ListTile>((e) =>
                ListTile(
                  title: Text(e?.date ?? "",
                      style: TextStyle(
                          color: const Color(0xFF000000),
                          fontSize: Dimensions.prayerListScreenContainerWidth16,
                          fontWeight: FontWeight.w200)
                  ),
                  leading: const Icon(Icons.bookmark_border_outlined),
                  onTap: () {
                    close(context, e);
                    Get.to(()=> const PrayerDetailScreen(), arguments: [
                      _selectedImage,
                      e.title,
                      e.prayerPoint,
                      e.id,
                      e.verse]);
                  },
                ),
            ).toList(),
          );
        }
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
        future: readJson(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Center(child: Text("Search could not find what you were looking for sorry!"),);
          }
          final result = snapshot.data as List<Scripture>;
          final results = result.where((element) => element.date.toString().toLowerCase().contains(query.toLowerCase()));
          return ListView(
            children: results.map<ListTile>((e) =>
                ListTile(
                  title: Text(e?.date ?? "",
                    style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: Dimensions.prayerListScreenContainerWidth14,
                        color: Color(0xFFBEC2CE)
                    ),
                  ),
                  leading: Icon(Icons.bookmark_border_outlined),
                  onTap: () {
                    query = e.date!;
                    showResults(context);
                  },
                ),
            ).toList(),
          );
        }
    );
  }

  List images = [
    "images/child(26).jpg",
    "images/child(27).jpg",
    "images/child(28).jpg",
    "images/child(29).jpg",
    "images/child(30).jpg",
    "images/child(31).jpg",
    "images/child(32).jpg",
    "images/child(33).jpg",
    "images/child(34).jpg",
    "images/child(35).jpg",
    "images/child(36).jpg",
    "images/child(37).jpg",
    "images/child(38).jpg",
    "images/child(39).jpg",
    "images/child(40).jpg",
    "images/child(41).jpg",
    "images/child(42).jpg",
    "images/child(43).jpg",
    "images/child(44).jpg",
  ];
  
}