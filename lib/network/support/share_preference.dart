import 'dart:convert';

import 'package:cbs_erp_project/screens/login_screen/model/UserLoginModel.dart';
import 'package:cbs_erp_project/screens/login_screen/model/auth_model.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SharedPreferenceManager {
  static const String oauth = "oauth";
  static const String walkthrough = "walkthrough";
  static const String themeColorKey = "themeColor";
  static const String darkModeKey = "darkMode";
  static const String checkInCheckOutValue = "checkInCheckOutValue";
  static const String baseUrl = 'base_url';
  static const String loginDeviceToken = 'login_device_token';
  static const String otpPermanentDeviceToken = 'OtpPermanentDeviceToken';
  static const String userObjKey = "user_data";
  static const String msgCount = "msg_count";
  static const String loginPin = "loginPin";
  static const String userDetails = 'userDetails';
  static const _biometricLogin = "biometricLogin";
  static const String profileImagePath = 'profile_image_path';

  static Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  static Future<void> clear() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }

  static setFirstCallOnboarding(bool oneTime) async {
    (await prefs).setBool(walkthrough, oneTime);
  }

  static getFirstCallOnboarding() async {
    return (await prefs).getBool(walkthrough) ?? false;
  }

  // Save theme color
  static Future<void> setThemeColor(int colorValue) async {
    (await prefs).setInt(themeColorKey, colorValue);
  }

  static Future<int?> getThemeColor() async {
    return (await prefs).getInt(themeColorKey);
  }

  // Save dark mode
  static Future<void> setDarkMode(bool isDark) async {
    (await prefs).setBool(darkModeKey, isDark);
  }

  static Future<bool> getDarkMode() async {
    return (await prefs).getBool(darkModeKey) ?? false;
  }

  static Future<void> setBaseUrl(String url) async {
    (await prefs).setString(baseUrl, url);
  }

  static Future<String> getBaseUrl() async {
    return (await prefs).getString(baseUrl) ?? "";
  }

  static Future<void> setLoginDeviceToken(String url) async {
    (await prefs).setString(loginDeviceToken, url);
  }

  static Future<String> getLoginDeviceToken() async {
    return (await prefs).getString(loginDeviceToken) ?? "";
  }

  static Future<void> setOtpPermanentDeviceToken(String url) async {
    (await prefs).setString(otpPermanentDeviceToken, url);
  }

  static Future<String> getOtpPermanentDeviceToken() async {
    return (await prefs).getString(otpPermanentDeviceToken) ?? "";
  }

  static Future<void> setUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    String userString = jsonEncode(user.toJson());
    await prefs.setString(userObjKey, userString);
  }

  static Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString(userObjKey);

    if (userString != null) {
      Map<String, dynamic> json = jsonDecode(userString);
      return User.fromJson(json);
    }
    return null;
  }

  static Future<void> setMsgCount(int colorValue) async {
    (await prefs).setInt(msgCount, colorValue);
  }

  static Future<int?> getMsgCount() async {
    return (await prefs).getInt(msgCount);
  }

  static Future<void> setLoginPin(String url) async {
    (await prefs).setString(loginPin, url);
  }

  static Future<String> getLoginPin() async {
    return (await prefs).getString(loginPin) ?? "";
  }

  static Future<void> setUserLoginDetails(UserLoginPinModel user) async {
    final prefs = await SharedPreferences.getInstance();
    String userString = jsonEncode(user.toJson()); //
    await prefs.setString(userDetails, userString);
  }

  static Future<UserLoginPinModel?> getUserLoginDetails() async {
    final prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString(userDetails);

    if (userString != null) {
      Map<String, dynamic> json = jsonDecode(userString);
      return UserLoginPinModel.fromJson(json);
    }
    return null;
  }

  static Future setBiometricLogin(bool status) async {
    final _instance = await SharedPreferences.getInstance();
    await _instance.setBool(_biometricLogin, status);
  }

  static Future<bool?> getBiometricLogin() async {
    final _instance = await SharedPreferences.getInstance();
    final res = _instance.getBool(_biometricLogin);
    return res;
  }

  static Future<void> setProfileImagePath(String path) async {
    (await prefs).setString(profileImagePath, path);
  }

  static Future<String?> getProfileImagePath() async {
    return (await prefs).getString(profileImagePath);
  }

  static Future<void> clearProfileImagePath() async {
    (await prefs).remove(profileImagePath);
  }
}