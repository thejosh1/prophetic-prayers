import 'package:shared_preferences/shared_preferences.dart';

 Future<String> getStreak() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();
  int value = 0;
  pref.setInt("key", (value + 1));
  pref.getInt("key") ?? 0;
  print(pref.getInt("key"));
  String string = pref.getInt("key").toString();
  print(string);
  return string;

}

