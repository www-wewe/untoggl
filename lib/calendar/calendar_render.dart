import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:kalender/kalender.dart';
import 'package:untoggl_project/calendar/calendar_parts/calendar_multi_day_builder.dart';
import 'package:untoggl_project/calendar/calendar_parts/calendar_schedule_builder.dart';
import 'package:untoggl_project/calendar/calendar_parts/calendar_tile_builder.dart';
import 'package:untoggl_project/calendar/calendar_parts/calendar_view_choose.dart';
import 'package:untoggl_project/calendar/calendar_view_conf/calendar_day_view.dart';
import 'package:untoggl_project/calendar/calendar_view_conf/calendar_month_view.dart';
import 'package:untoggl_project/calendar/calendar_view_conf/calendar_week_view.dart';
import 'package:untoggl_project/common/models/event.dart';
import 'package:untoggl_project/common/services/local_services/user_input_service.dart';

class CalendarRender extends StatefulWidget {
  final CalendarEventsController<Event> eventsController;
  final CalendarController calendarController;

  const CalendarRender({
    super.key,
    required this.eventsController,
    required this.calendarController,
  });

  @override
  State<CalendarRender> createState() => _CalendarRenderState();
}

class _CalendarRenderState extends State<CalendarRender> {
  double _calendarScale = 1;
  double _baseCalendarScale = 1;

  String _calendarView = 'Day';
  late ViewConfiguration _viewConfiguration;

  @override
  void initState() {
    super.initState();
    _viewConfiguration = _updateView(_calendarView);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CalendarViewChoose(onViewSelected: _onViewSelected),
        Expanded(
          child: GestureDetector(
            onScaleStart: _onScaleStart,
            onScaleUpdate: _onScaleUpdate,
            child: CalendarView(
              eventsController: widget.eventsController,
              controller: widget.calendarController,
              tileBuilder: calendarTileBuilder,
              multiDayTileBuilder: multiDayTileBuilder,
              scheduleTileBuilder: scheduleTileBuilder,
              eventHandlers: _initEventHandlers(context),
              viewConfiguration: _viewConfiguration,
            ),
          ),
        ),
      ],
    );
  }

  void _onScaleStart(ScaleStartDetails details) {
    _baseCalendarScale = _calendarScale;
  }

  void _onScaleUpdate(ScaleUpdateDetails details) {
    if (details.scale == 1.0) {
      return; // Do nothing if scale hasn't changed
    }

    setState(() {
      _calendarScale = (_baseCalendarScale * details.scale).clamp(1, 50);
      widget.calendarController.adjustHeightPerMinute(_calendarScale);
    });
  }

  void _onViewSelected(String view) {
    setState(() {
      _calendarView = view;
      _viewConfiguration = _updateView(view);
    });
  }

  CalendarEventHandlers _initEventHandlers(BuildContext context) {
    return CalendarEventHandlers(
      onEventTapped: (event) async {
        final task = event.eventData as Event;
        await context.push('/tasks/${task.id}');
      },
      onCreateEvent: (timeRange) {
        final DateTime start = timeRange.start;
        GetIt.instance<UserInputService>().startsAt = start;
        context.push('/tasks/date');
        return null;
      },
    );
  }

  ViewConfiguration _updateView(String view) {
    switch (view) {
      case 'Day':
        return calendarDayView();
      case 'Week':
        return calendarWeekView();
      case 'Month':
        return calendarMonthView();
      default:
        return calendarDayView();
    }
  }
}
