import 'dart:convert';

import 'package:flutter/services.dart' as rootBundle;
import 'package:prophetic_prayers/models/academy.dart';
import 'package:prophetic_prayers/models/blessing.dart';
import 'package:prophetic_prayers/models/calling.dart';
import 'package:prophetic_prayers/models/discipline.dart';
import 'package:prophetic_prayers/models/lifestyle.dart';
import '../models/career.dart';
import '../models/health.dart';
import '../models/marriage.dart';
import '../models/prayers.dart';
import '../models/prosperity.dart';
import '../models/warfare.dart';


Future<List<Scripture>> readJson() async {
  //read the json file
  final jsonData = await rootBundle.rootBundle.loadString('json/scriptures.json');

  final list = json.decode(jsonData) as List<dynamic>;
  return list.map((e) => Scripture.fromJson(e)).toList();
}

Future<List<ProsperityScripture>> readScriptureJson() async {
  final jsonData = await rootBundle.rootBundle.loadString('json/prosperityscriptures.json');

  final list = json.decode(jsonData) as List<dynamic>;
  return list.map((e) => ProsperityScripture.fromJson(e)).toList();
}

Future<List<Academy>> readAcademyJson() async {
  final jsonData = await rootBundle.rootBundle.loadString('json/academic_scriptures.json');

  final list = json.decode(jsonData) as List<dynamic>;
  return list.map((e) => Academy.fromJson(e)).toList();
}

Future<List<Blessings>> readBlessingsJson() async {
  final jsonData = await rootBundle.rootBundle.loadString('json/the_blessing_scripture.json');

  final list = json.decode(jsonData) as List<dynamic>;
  return list.map((e) => Blessings.fromJson(e)).toList();
}

Future<List<Calling>> readCallingJson() async {
  final jsonData = await rootBundle.rootBundle.loadString('json/calling_scriptures.json');
  
  final list = json.decode(jsonData) as List<dynamic>;
  return list.map((e) => Calling.fromJson(e)).toList();
}

Future<List<Career>> readCareerJson() async {
  final jsonData = await rootBundle.rootBundle.loadString('json/professional_career_scriptures.json');

  final list = json.decode(jsonData) as List<dynamic>;
  return list.map((e) => Career.fromJson(e)).toList();
}

Future<List<Discipline>> readDisciplineJson() async {
  final jsonData = await rootBundle.rootBundle.loadString('json/discpline_scriptures.json');

  final list = json.decode(jsonData) as List<dynamic>;
  return list.map((e) => Discipline.fromJson(e)).toList();
}

Future<List<Health>> readHealthJson() async {
  final jsonData = await rootBundle.rootBundle.loadString('json/health_scriptures.json');

  final list = json.decode(jsonData) as List<dynamic>;
  return list.map((e) => Health.fromJson(e)).toList();
}

Future<List<LifeStyle>> readLifeStyleJson() async {
  final jsonData = await rootBundle.rootBundle.loadString('json/lifestyle_scriptures.json');

  final list = json.decode(jsonData) as List<dynamic>;
  return list.map((e) => LifeStyle.fromJson(e)).toList();
}

Future<List<Marriage>> readMarriageJson() async {
  final jsonData = await rootBundle.rootBundle.loadString('json/marriage_scriptures.json');

  final list = json.decode(jsonData) as List<dynamic>;
  return list.map((e) => Marriage.fromJson(e)).toList();
}

Future<List<Warfare>> readWarfareJson() async {
  final jsonData = await rootBundle.rootBundle.loadString('json/spiritual_warfare_scriptures.json');

  final list = json.decode(jsonData) as List<dynamic>;
  return list.map((e) => Warfare.fromJson(e)).toList();
}



