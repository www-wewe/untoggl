import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/services/firebase_service.dart';
import 'package:untoggl_project/settings/settings.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final _authService = GetIt.instance.get<FirebaseService>();

  @override
  Widget build(BuildContext context) {
    if (_authService.isUserLoggedInFuture) {
      return Settings();
    }
    return const Center(
      child: Text('Please log in to view your settings'),
    );
  }
}
