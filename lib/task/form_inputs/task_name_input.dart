import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/services/local_services/user_input_service.dart';

String DEFAULT_TASK_NAME = 'Task Name';
String DEFAULT_TASK_NAME_ERROR = 'Please enter task name';

class TaskNameInput extends StatelessWidget {
  final String taskName;
  final _inputService = GetIt.instance<UserInputService>();

  TaskNameInput({super.key, this.taskName = ''});

  @override
  Widget build(BuildContext context) {
    _inputService.taskName = taskName;

    return TextFormField(
      initialValue: taskName,
      decoration: InputDecoration(
        labelText: DEFAULT_TASK_NAME,
        icon: const Icon(Icons.edit),
      ),
      onSaved: (value) => _inputService.taskName = value!,
      validator: (value) => value!.isEmpty ? DEFAULT_TASK_NAME_ERROR : null,
    );
  }
}
