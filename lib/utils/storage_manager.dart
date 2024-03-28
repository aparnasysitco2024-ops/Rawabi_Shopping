import 'package:shared_preferences/shared_preferences.dart';

class StorageManager {
  static String keyIsLogin = "keyIsLogin";
  static String keyGuestID = "keyGuestID";
  static String keyUserID = "keyUserID";
  static String keyUserName = "keyUserName";
  static String keyUserLevel = "keyUserLevel";
  static String keyCompany_name = "keyCompany_name";
  static String keyCompany_logo = "keyCompany_logo";
  static String keyUserEmail = "keyUserEmail";
  static String keyUserMobile = "keyUserMobile";
  static String keyLanguage = "keyLanguage";
  static String keyFirebaseToken = "keyFirebaseToken";
  static String keyFirebaseTokenSend = "keyFirebaseTokenSend";

  static String keyStoreAddress = "keyStoreAddress";
  static String keyStoreID = "keyStoreID";
  static String keyStoreLat = "keyStoreLat";
  static String keyStoreLng = "keyStoreLng";

  static String keyDefaultAddressId = "keyDefaultAddressId";
  static String keyDefaultAddress = "keyDefaultAddress";

  static void saveData(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else if (value is double) {
      prefs.setDouble(key, value);
    } else {}
  }

  static void saveLanguage(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(key, value);
    if (value == 'en') {
      prefs.setString("Country Code", "US");
    } else {
      prefs.setString("Country Code", "SA");
    }
  }

  static Future<String> getLanguage() async {
    final prefs = await SharedPreferences.getInstance();
    String obj = prefs.getString(keyLanguage) ?? setAndReturnLang("eng");
    return obj;
  }

  static String setAndReturnLang(String lang) {
    saveLanguage(keyLanguage, lang);
    return lang;
  }

  static Future<String> readData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String obj = prefs.getString(key) ?? '';
    return obj;
  }

  static Future<double> readDataDouble(String key) async {
    final prefs = await SharedPreferences.getInstance();
    var obj = prefs.getDouble(key) ?? 0.0;
    return obj;
  }


  static Future<String> getUserID() async {
    final prefs = await SharedPreferences.getInstance();
    String obj = prefs.getString(keyUserID) ?? '0';
    return obj;
  }

  static Future<String> getGuestID() async {
    String obj = "0";
    final prefs = await SharedPreferences.getInstance();
    String userID = prefs.getString(keyUserID) ?? '0';
    if (userID == '0') {
      obj = prefs.getString(keyGuestID) ?? '0';
    }
    return obj;
  }

  static Future<bool> readDataBool(String key) async {
    final prefs = await SharedPreferences.getInstance();
    bool obj = prefs.getBool(key) ?? false;
    return obj;
  }

  static Future<bool> deleteData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  static clearData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
