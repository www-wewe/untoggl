import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/calendar/calendar_drawer.dart';
import 'package:untoggl_project/common/services/local_services/join_service.dart';
import 'package:untoggl_project/common/widgets/handling_stream_builder.dart';

class CalendarPage extends StatelessWidget {
  CalendarPage({super.key});

  final _joinService = GetIt.instance<JoinService>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: HandlingStreamBuilder(
            stream: _joinService.getAllTasksForUser,
            builder: (context, snapshot) {
              final tasks = snapshot;
              return CalendarDrawer(tasks: tasks);
            },
          ),
        ),
      ],
    );
  }
}
