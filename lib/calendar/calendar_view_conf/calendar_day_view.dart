import 'package:kalender/kalender.dart';

DayConfiguration calendarDayView() {
  return DayConfiguration(
    timelineWidth: 56,
    multiDayTileHeight: 12,
    verticalStepDuration: const Duration(minutes: 15),
    verticalSnapRange: const Duration(minutes: 15),
    newEventDuration: const Duration(minutes: 15),
  );
}
