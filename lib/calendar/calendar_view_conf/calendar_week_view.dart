import 'package:kalender/kalender.dart';

WeekConfiguration calendarWeekView() {
  return WeekConfiguration(
    timelineWidth: 56,
    multiDayTileHeight: 24,
    eventSnapping: false,
    timeIndicatorSnapping: false,
    createEvents: true,
    createMultiDayEvents: true,
    verticalStepDuration: const Duration(minutes: 15),
    verticalSnapRange: const Duration(minutes: 15),
    newEventDuration: const Duration(minutes: 15),
    paintWeekNumber: true,
  );
}
