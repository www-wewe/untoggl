import 'package:kalender/kalender.dart';

MonthConfiguration calendarMonthView() {
  return MonthConfiguration(
    firstDayOfWeek: 1,
    multiDayTileHeight: 24,
    enableResizing: true,
    createMultiDayEvents: true,
    enableRescheduling: true,
  );
}
