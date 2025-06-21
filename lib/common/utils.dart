import 'package:nanoid2/nanoid2.dart';
import 'package:untoggl_project/common/enums/supported_languages.dart';
import 'package:untoggl_project/common/models/task.dart';
import 'package:untoggl_project/common/models/team.dart';
import 'package:untoggl_project/common/models/user_settings.dart';

String capitalise(String string) {
  return string[0].toUpperCase() + string.substring(1);
}

String trimToLength(String input, {int length = 32}) {
  return input.length > length ? input.substring(0, length) : input;
}

Task emptyTask() {
  return Task(
    id: generateRandomUUID(),
    name: '',
    description: '',
    completed: false,
    startsAt: DateTime.now(),
    endsAt: DateTime.now(),
  );
}

Team emptyTeam() {
  return Team(
    id: generateRandomUUID(),
    name: '',
    adminIds: [],
    memberIds: [],
  );
}

UserSettings emptyUserSettings() {
  return UserSettings(
    id: generateRandomUUID(),
  );
}

String generateRandomUUID() {
  return nanoid(length: 64);
}

bool isTimeBetween(DateTime time, DateTime startTime, DateTime endTime) {
  return time.isAfter(startTime) && time.isBefore(endTime);
}

SupportedLanguage fromShortcode(String shortCode) {
  final lang = SupportedLanguage.values.firstWhere(
    (element) => element.shortCode == shortCode,
    orElse: () => SupportedLanguage.english,
  );
  return lang;
}
