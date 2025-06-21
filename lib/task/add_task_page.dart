import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/models/task.dart';
import 'package:untoggl_project/common/services/local_services/join_service.dart';
import 'package:untoggl_project/common/utils.dart';
import 'package:untoggl_project/common/widgets/handling_stream_builder.dart';
import 'package:untoggl_project/task/form_inputs/task_assign_to_team.dart';
import 'package:untoggl_project/task/form_inputs/task_calendar_input.dart';
import 'package:untoggl_project/task/form_inputs/task_description_input.dart';
import 'package:untoggl_project/task/form_inputs/task_duration_input.dart';
import 'package:untoggl_project/task/form_inputs/task_name_input.dart';
import 'package:untoggl_project/task/task_add_button.dart';
import 'package:untoggl_project/task/task_edit_buttons.dart';

import '../common/services/local_services/user_input_service.dart';

class AddTaskPage extends StatelessWidget {
  final String taskId;
  final bool customStartDate;
  final _inputService = GetIt.instance<UserInputService>();

  AddTaskPage({
    super.key,
    this.taskId = '',
    this.customStartDate = false,
  });

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final Stream<Task> taskStream = _initializeTaskStream();

    return HandlingStreamBuilder(
      stream: taskStream,
      builder: (context, snapshot) {
        final task = snapshot;
        final taskDuration = task.endsAt.difference(task.startsAt);

        return Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(height: 10),
                TaskNameInput(taskName: task.name),
                const SizedBox(height: 10),
                TaskDescriptionInput(taskDescription: task.description),
                const SizedBox(height: 10),
                TaskCalendarInput(taskDate: task.startsAt),
                const SizedBox(height: 10),
                TaskDurationInput(taskDuration: taskDuration),
                const SizedBox(height: 10),
                TaskAssignToTeam(
                  assignedTo: task.assignedTeam,
                  taskId: task.id,
                ),
                const SizedBox(height: 20),
                _drawButtons(context, formKey),
              ],
            ),
          ),
        );
      },
    );
  }

  Stream<Task> _initializeTaskStream() {
    // If we want to create a task from calendar, we need to set the start date
    Task initialTask = emptyTask();
    if (customStartDate) {
      // We need to set the start date and end date to the same value
      initialTask = initialTask.copyWith(
        startsAt: _inputService.startsAt,
        endsAt: _inputService.startsAt,
      );
      _inputService.clear();
      _inputService.startsAt = initialTask.startsAt;
    } else {
      _inputService.clear();
    }

    if (taskId.isNotEmpty) {
      return GetIt.instance<JoinService>().getById(taskId);
    } else {
      return Stream.value(initialTask);
    }
  }

  Widget _drawButtons(BuildContext context, GlobalKey<FormState> formKey) {
    if (taskId.isEmpty) {
      return TaskAddButton(formKey: formKey);
    }
    return TaskEditButtons(formKey: formKey, taskId: taskId);
  }
}
