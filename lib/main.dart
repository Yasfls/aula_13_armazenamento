import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';

import 'models/user_profile.dart';
import 'services/settings_service.dart';
import 'services/migration_service.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(UserProfileAdapter());

  await Hive.openBox<UserProfile>('profileBox');

  final settingsService = SettingsService();
  await settingsService.loadSettings();

  await MigrationService().migrate();

  runApp(
    ChangeNotifierProvider(
      create: (_) => settingsService,
      child: const LocalVaultApp(),
    ),
  );
}

class LocalVaultApp extends StatelessWidget {
  const LocalVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    final settings = Provider.of<SettingsService>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'LocalVault',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode:
          settings.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}