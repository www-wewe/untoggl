/*
  User Input Service
  This service is used to get user input from the app, such as text input, date input, etc.
 */
import 'package:flutter/material.dart';
import 'package:untoggl_project/common/enums/allowed_colors.dart';
import 'package:untoggl_project/common/models/task.dart';
import 'package:untoggl_project/common/models/team.dart';
import 'package:untoggl_project/common/utils.dart';

class UserInputService extends ChangeNotifier {
  // User Profile Page
  String userName = '';
  String userEmail = '';
  String userPassword = '';

  // Add Task Page
  String taskName = '';
  String taskDescription = '';
  Duration duration = Duration.zero;
  bool completed = false;
  DateTime startsAt = DateTime.now();
  Team? taskTeamAssignment;

  void setTask(Task task) {
    taskName = task.name;
    taskDescription = task.description;
    duration = task.endsAt.difference(task.startsAt);
    completed = task.completed;
    startsAt = task.startsAt;
    taskTeamAssignment = task.assignedTeam;
  }

  Task getNewTask() {
    final endsAt = startsAt.add(duration);
    return Task(
      id: generateRandomUUID(),
      name: taskName,
      description: taskDescription,
      completed: completed,
      startsAt: startsAt,
      endsAt: endsAt,
      assignedTeam: taskTeamAssignment,
    );
  }

  // List of person names (Add member dialog)
  List<String> personNames = [];

  // List of pickable persons
  List<({String id, bool value})> pickablePersons = [];

  // Pickable list input for the app
  void initPickablePersons(List<String> persons) {
    pickablePersons = persons.map((e) => (id: e, value: false)).toList();
  }

  void togglePickablePerson(String personId) {
    final index = pickablePersons.indexWhere((el) => el.id == personId);
    if (index == -1) {
      return;
    }
    pickablePersons[index] =
        (id: personId, value: !pickablePersons[index].value);
    notifyListeners();
  }

  List<String> getSelectedPersonIds() {
    return pickablePersons
        .where((element) => element.value)
        .map((e) => e.id)
        .toList();
  }

  void removePerson(String personId) {
    pickablePersons.removeWhere((element) => element.id == personId);
  }

  ({String id, bool value}) getPerson(String personId) {
    final index = pickablePersons.indexWhere((el) => el.id == personId);
    if (index == -1) {
      return (id: "-1", value: false);
    }
    return pickablePersons[index];
  }

  bool isPicked(String personId) {
    final index = pickablePersons.indexWhere((el) => el.id == personId);
    if (index == -1) {
      return false;
    }
    return pickablePersons[index].value;
  }

  // Team Form
  String teamName = '';
  AllowedColors teamColor = AllowedColors.red;

  // Clears the user input used by the app
  void clear() {
    pickablePersons = [];
    personNames = [];
    taskName = '';
    taskDescription = '';
    duration = Duration.zero;
    completed = false;
    startsAt = DateTime.now();
    teamName = '';
    teamColor = AllowedColors.red;
    taskTeamAssignment = null;

    userEmail = '';
    userPassword = '';
    userName = '';
    notifyListeners();
  }

  // Snackbars with user input related content
  void showSnackbar(BuildContext context, String message) {
    print(message);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
