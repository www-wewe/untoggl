import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/services/firebase_service.dart';
import 'package:untoggl_project/common/services/local_services/join_service.dart';
import 'package:untoggl_project/common/services/local_services/notification_service.dart';
import 'package:untoggl_project/common/services/local_services/preferences_service.dart';
import 'package:untoggl_project/common/services/local_services/storage_service.dart';
import 'package:untoggl_project/common/services/local_services/user_input_service.dart';
import 'package:untoggl_project/common/services/newServices/service_settings_store.dart';
import 'package:untoggl_project/common/services/newServices/service_task_store.dart';
import 'package:untoggl_project/common/services/newServices/service_team_store.dart';
import 'package:untoggl_project/firebase_options.dart';
import 'package:untoggl_project/theme_encapsulator.dart';

const _INITIAL_ROUTE = '/intro';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  GetIt.instance.registerSingleton<FirebaseService>(FirebaseService());
  GetIt.instance
      .registerSingleton<ServiceSettingsStore>(ServiceSettingsStore());
  GetIt.instance.registerSingleton<NotificationService>(NotificationService());
  GetIt.instance.registerSingleton<ServiceTaskStore>(ServiceTaskStore());
  GetIt.instance.registerSingleton<ServiceTeamStore>(ServiceTeamStore());
  GetIt.instance.registerSingleton<PreferencesService>(PreferencesService());
  GetIt.instance.registerSingleton<UserInputService>(UserInputService());
  GetIt.instance.registerSingleton<StorageService>(StorageService());
  GetIt.instance.registerSingleton<JoinService>(JoinService());

  runApp(const ThemeEncapsulator(initialRoute: _INITIAL_ROUTE));
}
