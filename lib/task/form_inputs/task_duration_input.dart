import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/services/local_services/user_input_service.dart';
import 'package:untoggl_project/task/duration_form_field.dart';

String DEFAULT_TASK_DURATION = 'Task Duration';
String DEFAULT_TASK_DURATION_ERROR = 'Please enter task duration';

class TaskDurationInput extends StatelessWidget {
  final Duration taskDuration;
  final _inputService = GetIt.instance<UserInputService>();

  TaskDurationInput({super.key, required this.taskDuration});

  @override
  Widget build(BuildContext context) {
    _inputService.duration = taskDuration;

    return DurationFormField(
      initialValue: taskDuration,
      onSaved: (Duration? newValue) {
        _inputService.duration = newValue!;
      },
      validator: (Duration? value) => value == null || value.inMinutes == 0
          ? DEFAULT_TASK_DURATION_ERROR
          : null,
    );
  }
}
