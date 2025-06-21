import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DashboardCalendar extends StatelessWidget {
  final Function(DateTime) onDaySelected;
  final DateTime selectedDate;

  const DashboardCalendar({
    super.key,
    required this.onDaySelected,
    required this.selectedDate,
  });

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      focusedDay: selectedDate,
      calendarFormat: CalendarFormat.week,
      startingDayOfWeek: StartingDayOfWeek.monday,
      availableCalendarFormats: const {
        CalendarFormat.week: 'Week',
      },
      headerStyle: const HeaderStyle(
        titleCentered: true,
        formatButtonVisible: false,
      ),
      selectedDayPredicate: (day) {
        return isSameDay(selectedDate, day);
      },
      onDaySelected: (selectedDay, focusedDay) {
        if (!isSameDay(selectedDay, selectedDate)) {
          onDaySelected(selectedDay);
        }
      },
      onPageChanged: (focusedDay) {
        onDaySelected(focusedDay);
      },
    );
  }
}
