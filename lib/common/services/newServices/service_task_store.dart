import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/models/task.dart';
import 'package:untoggl_project/common/services/generic_firestore_service.dart';
import 'package:untoggl_project/common/services/local_services/notification_service.dart';

class ServiceTaskStore extends GenericFirestoreService<Task> {
  final _notificationService = GetIt.instance<NotificationService>();

  ServiceTaskStore() : super(collectionName: 'tasks');

  @override
  Task fromJson(Map<String, dynamic> map) {
    return Task.fromJson(map);
  }

  @override
  Future<void> create(Task item) async {
    item = item.copyWith(userId: firebase.userId);
    await super.create(item);
    await _notificationService.scheduleNotificationForTask(
        item, const Duration(minutes: 5));
  }

  @override
  Future<void> update(Task item) async {
    final itemFromInput = item.copyWith(
      userId: firebase.userId,
    );
    await super.update(itemFromInput);
  }
}
