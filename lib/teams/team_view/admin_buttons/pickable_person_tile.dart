import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/models/user_settings.dart';
import 'package:untoggl_project/common/services/firebase_service.dart';
import 'package:untoggl_project/common/services/local_services/user_input_service.dart';
import 'package:untoggl_project/common/services/newServices/service_settings_store.dart';
import 'package:untoggl_project/common/widgets/handling_future_builder.dart';

class PickablePersonTile extends StatelessWidget {
  final String userId;
  final _inputService = GetIt.instance<UserInputService>();
  final _settingsService = GetIt.instance<ServiceSettingsStore>();
  final _authService = GetIt.instance<FirebaseService>();

  PickablePersonTile({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return HandlingFutureBuilder(
      future: _settingsService.getByIdSync(userId),
      builder: (context, snapshot) {
        final settings = snapshot.data as UserSettings;
        final isUser = _authService.userId == userId;

        return ListTile(
          title: Text(isUser ? "${settings.email} (You)" : settings.email),
          subtitle: Text(userId),
          trailing: Checkbox(
            value: _inputService.isPicked(userId),
            onChanged: (value) {
              _inputService.togglePickablePerson(userId);
            },
          ),
        );
      },
    );
  }
}
