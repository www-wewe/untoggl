import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/services/local_services/join_service.dart';
import 'package:untoggl_project/common/widgets/handling_stream_builder.dart';
import 'package:untoggl_project/dashboard/dashboard_tasks/task_filterable_list.dart';

class DashboardTasks extends StatelessWidget {
  final DateTime selectedDate;
  final _joinService = GetIt.instance<JoinService>();

  DashboardTasks({super.key, required this.selectedDate});

  @override
  Widget build(BuildContext context) {
    if (selectedDate.hour != 0) {
      return const CircularProgressIndicator();
    }

    return HandlingStreamBuilder(
      stream: _joinService.getTasksByDay(selectedDate),
      builder: (context, snapshot) {
        final tasks = snapshot;
        if (tasks.isEmpty) {
          return const Text(
            'What a good day to start working on something new!',
          );
        }
        return TaskFilterableList(tasks: tasks);
      },
    );
  }
}
