import 'dart:convert';

import 'package:flutter/services.dart' as rootBundle;

import '../models/prosperity.dart';

Future<List<ProsperityScripture>> readScriptureJson() async {
  //read the json file
  final jsonData = await rootBundle.rootBundle.loadString('json/scripture1.json');

  final list = json.decode(jsonData) as List<dynamic>;
  return list.map((e) => ProsperityScripture.fromJson(e)).toList();
}