import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:untoggl_project/common/models/task.dart';
import 'package:untoggl_project/common/services/local_services/join_service.dart';
import 'package:untoggl_project/common/services/newServices/service_task_store.dart';
import 'package:untoggl_project/common/widgets/handling_stream_builder.dart';
import 'package:untoggl_project/dashboard/timer_widget.dart';

class CurrentlyWorkingOn extends StatelessWidget {
  CurrentlyWorkingOn({super.key});

  final _joinService = GetIt.instance<JoinService>();
  final _taskStore = GetIt.instance<ServiceTaskStore>();

  @override
  Widget build(BuildContext context) {
    return HandlingStreamBuilder(
      stream: _joinService.getCurrentlyWorkingOn,
      builder: (context, snapshot) {
        final tasks = snapshot;
        if (tasks.isEmpty) {
          return const Text('');
        }

        final task = tasks.first;
        return ListTile(
          title: const Text('Currently working on'),
          subtitle: Text(task.name),
          leading: IconButton(
            icon: const Icon(Icons.stop),
            onPressed: () {
              _endTask(task);
            },
          ),
          trailing: TimerWidget(
            start: task.startsAt,
            end: task.endsAt,
            onTaskEnd: () {
              _endTask(task);
            },
          ),
          onLongPress: () {},
          onTap: () {
            context.push('/tasks/${task.id}');
          },
        );
      },
    );
  }

  Future<void> _endTask(Task task) {
    return _taskStore
        .update(task.copyWith(endsAt: DateTime.now(), completed: true));
  }
}
