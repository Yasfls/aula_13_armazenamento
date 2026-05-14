import 'package:shared_preferences/shared_preferences.dart';

class MigrationService {
  static const int currentVersion = 2;

  Future<void> migrate() async {
    final prefs = await SharedPreferences.getInstance();

    final savedVersion = prefs.getInt('data_version') ?? 1;

    if (savedVersion < currentVersion) {
      final oldTheme = prefs.getBool('theme_dark');

      if (oldTheme != null) {
        await prefs.setBool('darkMode', oldTheme);
        await prefs.remove('theme_dark');
      }

      final oldLanguage = prefs.getString('app_language');

      if (oldLanguage != null) {
        await prefs.setString('language', oldLanguage);
        await prefs.remove('app_language');
      }

      await prefs.setInt('data_version', currentVersion);
    }
  }
}