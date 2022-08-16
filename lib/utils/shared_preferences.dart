import 'package:shared_preferences/shared_preferences.dart';

 class AppPreferences {
  static SharedPreferences? _preferences;

  static const _KeyPrayerTypes = "prayerType";
  static const _KeyImageName = "imageName";
  static const _KeyImageType = "imageType";

  static Future init() async =>
   _preferences = await SharedPreferences.getInstance();


  static Future setPrayerType(String prayerType) async =>
   await _preferences!.setString(_KeyPrayerTypes, prayerType);

  static Future setImageName(String imageName) async =>
  await _preferences!.setString(_KeyImageName, imageName);

  static Future setImageType(String imageType) async =>
  await _preferences!.setString(_KeyImageType, imageType);

  static getPrayertype() => _preferences!.getString(_KeyPrayerTypes);

  static getImageName() => _preferences!.getString(_KeyImageName);

  static getImageType() => _preferences!.getString(_KeyImageType);
}

