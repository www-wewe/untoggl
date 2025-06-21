import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untoggl_project/common/services/firebase_service.dart';
import 'package:untoggl_project/common/services/newServices/service_settings_store.dart';

class PreferencesService extends ChangeNotifier {
  final _settingsService = GetIt.I.get<ServiceSettingsStore>();
  final _authService = GetIt.I.get<FirebaseService>();
  bool firstRun = true;

  void _init() async {
    final sp = await SharedPreferences.getInstance();
    firstRun = sp.getBool('firstRun') ?? true;

    final settings = _settingsService.getByUserId(_authService.userId);
    settings.listen((sett) {
      if (sett == null) return;
      toggleTheme(darkMode: sett.darkMode);
    });
  }

  PreferencesService() {
    _init();
  }

  ThemeMode selectedTheme = ThemeMode.dark;

  void toggleTheme({bool darkMode = false}) {
    selectedTheme = darkMode ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
