import 'package:shared_preferences/shared_preferences.dart';

 class AppPreferences {
  static SharedPreferences? _preferences;

  static const _KeyPrayerTypes = "prayertype";

  static Future init() async =>
   _preferences = await SharedPreferences.getInstance();


  static Future setPrayerType(String prayertype) async =>
   await _preferences!.setString(_KeyPrayerTypes, prayertype);

  static getPrayertype() => _preferences!.getString(_KeyPrayerTypes);
}

