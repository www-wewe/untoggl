import 'package:flutter/material.dart';
import 'package:kalender/kalender.dart';
import 'package:untoggl_project/calendar/calendar_render.dart';
import 'package:untoggl_project/common/models/event.dart';
import 'package:untoggl_project/common/models/task.dart';

class CalendarDrawer extends StatelessWidget {
  final List<Task> tasks;

  const CalendarDrawer({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    final eventsController = CalendarEventsController<Event>();
    _parseTasks(eventsController);

    final calendarController = CalendarController();

    return CalendarRender(
      eventsController: eventsController,
      calendarController: calendarController,
    );
  }

  void _parseTasks(CalendarEventsController<Event> eventsController) {
    for (final task in tasks) {
      final taskColor = task.assignedTeam?.teamColor.color;
      eventsController.addEvent(
        CalendarEvent(
          dateTimeRange: DateTimeRange(
            start: task.startsAt,
            end: task.endsAt,
          ),
          modifiable: false,
          eventData: Event(
            id: task.id,
            title: task.name,
            description: task.description,
            color: taskColor ?? Colors.blue,
          ),
        ),
      );
    }
  }
}
