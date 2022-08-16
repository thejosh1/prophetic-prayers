import 'dart:convert';

import 'package:flutter/services.dart' as rootBundle;
import '../models/prayers.dart';
import '../models/prosperity.dart';

Future<List<Scripture>> readJson() async {
  //read the json file
  final jsonData = await rootBundle.rootBundle.loadString('json/scriptures.json');

  final list = json.decode(jsonData) as List<dynamic>;
  return list.map((e) => Scripture.fromJson(e)).toList();
}

Future<List<ProsperityScripture>> readScriptureJson() async {
  //read the json file
  final jsonData = await rootBundle.rootBundle.loadString('json/prosperity.json');

  final list = json.decode(jsonData) as List<dynamic>;
  return list.map((e) => ProsperityScripture.fromJson(e)).toList();
}






