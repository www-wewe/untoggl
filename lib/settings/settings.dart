import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/services/local_services/preferences_service.dart';
import 'package:untoggl_project/common/services/newServices/service_settings_store.dart';
import 'package:untoggl_project/common/widgets/handling_stream_builder.dart';
import 'package:untoggl_project/settings/settings_card.dart';

import '../common/services/local_services/notification_service.dart';

class Settings extends StatelessWidget {
  Settings({super.key});

  final _settingsService = GetIt.instance.get<ServiceSettingsStore>();
  final _notificationService = GetIt.instance.get<NotificationService>();
  final _preferencesService = GetIt.instance.get<PreferencesService>();

  @override
  Widget build(BuildContext context) {
    return HandlingStreamBuilder(
      stream: _settingsService.getByUser,
      builder: (context, snapshot) {
        final settings = snapshot;

        if (settings == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              SettingsCard(
                label: 'Notifications',
                child: Switch(
                  value: settings.notifications,
                  onChanged: (value) {
                    final newSetting = settings.copyWith(
                      notifications: value,
                    );
                    _settingsService.update(newSetting);

                    // Ask for permissions if the user enables notifications
                    if (value) {
                      _notificationService.askPermissions();
                    }
                  },
                ),
              ),
              SettingsCard(
                label: 'Dark Mode',
                child: Switch(
                  value: settings.darkMode,
                  onChanged: (value) {
                    final newSetting = settings.copyWith(
                      darkMode: value,
                    );
                    _settingsService.update(newSetting);
                    _preferencesService.toggleTheme(darkMode: value);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
