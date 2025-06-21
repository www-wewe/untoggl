import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/services/local_services/user_input_service.dart';
import 'package:untoggl_project/task/util/task_constants.dart';

class TaskDescriptionInput extends StatelessWidget {
  final String taskDescription;
  final _inputService = GetIt.instance<UserInputService>();

  TaskDescriptionInput({super.key, required this.taskDescription});

  @override
  Widget build(BuildContext context) {
    _inputService.taskDescription = taskDescription;

    return TextFormField(
      initialValue: taskDescription,
      onSaved: (value) => _inputService.taskDescription = value!,
      decoration: InputDecoration(
        labelText: DEFAULT_TASK_DESCRIPTION,
        icon: const Icon(Icons.description),
      ),
      validator: (value) =>
          value!.isEmpty ? DEFAULT_TASK_DESCRIPTION_ERROR : null,
    );
  }
}
