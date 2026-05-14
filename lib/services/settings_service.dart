import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService extends ChangeNotifier {
  bool isDarkMode = false;
  bool notificationsEnabled = true;
  String language = 'Português';

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    isDarkMode = prefs.getBool('darkMode') ?? false;
    notificationsEnabled = prefs.getBool('notifications') ?? true;
    language = prefs.getString('language') ?? 'Português';

    notifyListeners();
  }

  Future<void> toggleDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    isDarkMode = value;

    await prefs.setBool('darkMode', value);

    notifyListeners();
  }

  Future<void> toggleNotifications(bool value) async {
    final prefs = await SharedPreferences.getInstance();

    notificationsEnabled = value;

    await prefs.setBool('notifications', value);

    notifyListeners();
  }

  Future<void> changeLanguage(String value) async {
    final prefs = await SharedPreferences.getInstance();

    language = value;

    await prefs.setString('language', value);

    notifyListeners();
  }

  bool get isEnglish => language == 'English';
}