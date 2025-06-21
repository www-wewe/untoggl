import 'package:untoggl_project/common/models/user_settings.dart';
import 'package:untoggl_project/common/services/generic_firestore_service.dart';

class ServiceSettingsStore extends GenericFirestoreService<UserSettings> {
  ServiceSettingsStore() : super(collectionName: 'user_settings');

  Future<UserSettings?> get getSettings async {
    if (firebase.userId.isEmpty) {
      return null;
    }
    return await getByIdSync(firebase.userId);
  }

  @override
  UserSettings fromJson(Map<String, dynamic> map) {
    return UserSettings.fromJson(map);
  }

  @override
  Future<void> create(UserSettings item) async {
    item = item.copyWith(userId: firebase.userId);
    await super.create(item);
  }

  @override
  Future<void> update(UserSettings item) async {
    item = item.copyWith(userId: firebase.userId);
    await super.update(item);
  }
}
