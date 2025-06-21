import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untoggl_project/common/models/task.dart';
import 'package:untoggl_project/common/services/firebase_service.dart';
import 'package:untoggl_project/common/services/local_services/preferences_service.dart';
import 'package:untoggl_project/common/services/newServices/service_settings_store.dart';
import 'package:untoggl_project/common/services/newServices/service_task_store.dart';
import 'package:untoggl_project/common/services/newServices/service_team_store.dart';

/*
  * This is the new JoinService class. It is a service that is used for queries,
  * that require data from multiple collections.
  *
  * @author Matej Hakoš
 */
class JoinService {
  final _authService = GetIt.instance<FirebaseService>();
  final ServiceTaskStore _taskStore = GetIt.instance<ServiceTaskStore>();
  final ServiceTeamStore _teamsStore = GetIt.instance<ServiceTeamStore>();
  final _preferencesService = GetIt.instance<PreferencesService>();
  final ServiceSettingsStore _settingsStore =
      GetIt.instance<ServiceSettingsStore>();

  Stream<List<Task>> get getAllTasksForUser {
    final userId = _authService.userId;
    if (userId.isEmpty) {
      return const Stream.empty();
    }
    final tasksRef =
        _taskStore.collection.where('userId', isEqualTo: userId).snapshots();
    final teamsRef = _teamsStore.collection
        .where('memberIds', arrayContains: userId)
        .snapshots();

    return _returnTaskTeamStream(tasksRef, teamsRef);
  }

  Stream<List<Task>> getTasksByDay(DateTime day) {
    final userId = _authService.userId;
    if (userId.isEmpty) {
      return const Stream.empty();
    }
    final dayFix = day.add(const Duration(days: 1));
    final tasksRef = _taskStore.collection
        .where('userId', isEqualTo: userId)
        .where('startsAt', isGreaterThanOrEqualTo: day)
        .where('startsAt', isLessThan: dayFix)
        .snapshots();
    final teamsRef = _teamsStore.collection
        .where('memberIds', arrayContains: userId)
        .snapshots();

    return _returnTaskTeamStream(tasksRef, teamsRef);
  }

  Stream<List<Task>> get getCurrentlyWorkingOn {
    final userId = _authService.userId;
    if (userId.isEmpty) {
      return const Stream.empty();
    }
    final tasksRef = _taskStore.collection
        .where('userId', isEqualTo: userId)
        .where('startsAt', isLessThan: DateTime.now())
        .where('completed', isEqualTo: false)
        .snapshots();
    final teamsRef = _teamsStore.collection
        .where('memberIds', arrayContains: userId)
        .snapshots();

    return _returnTaskTeamStream(tasksRef, teamsRef);
  }

  Stream<Task> getById(String id) {
    return getAllTasksForUser.map(
      (tasks) => tasks.firstWhere((task) {
        return task.id == id;
      }),
    );
  }

  CombineLatestStream<dynamic, List<Task>> _returnTaskTeamStream(
    Stream<QuerySnapshot<Map<String, dynamic>>> tasksRef,
    Stream<QuerySnapshot<Map<String, dynamic>>> teamsRef,
  ) {
    return CombineLatestStream.combine2(
      tasksRef,
      teamsRef,
      (
        QuerySnapshot<Map<String, dynamic>> tasks,
        QuerySnapshot<Map<String, dynamic>> teams,
      ) {
        return tasks.docs
            .map((doc) {
              final data = doc.data();
              final assignedTo = data['assignedTo'] as String?;
              if (assignedTo != null) {
                final team = teams.docs
                    .where((element) => element.get("id") == assignedTo);
                final teamData = team.first.data();
                data['assignedTo'] = teamData;
              }

              return Task.fromJson(data);
            })
            .nonNulls
            .toList();
      },
    );
  }

  Future<void> addTeamMembers(String teamId, List<String> userEmails) async {
    final team = await _teamsStore.getByIdSync(teamId);
    final List<String> userIds = [];
    for (final email in userEmails) {
      final user = await _settingsStore.collection
          .where('email', isEqualTo: email)
          .get();
      final userDoc = user.docs.first;
      if (userDoc.exists) {
        userIds.add(userDoc['id'] as String);
      }
      final newMembers = team.memberIds + userIds;
      await _teamsStore.update(team.copyWith(memberIds: newMembers));
    }
  }

  Future<bool> showIntroductionScreen() async {
    final userLoggedIn = await _authService.isUserLoggedIn.first;
    final sp = await SharedPreferences.getInstance();
    final firstRun = sp.getBool("firstRun") ?? true;
    return userLoggedIn && firstRun;
  }
}
