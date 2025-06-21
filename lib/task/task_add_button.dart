import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/services/local_services/user_input_service.dart';
import 'package:untoggl_project/common/services/newServices/service_task_store.dart';

class TaskAddButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final _inputService = GetIt.instance<UserInputService>();
  final _taskService = GetIt.instance<ServiceTaskStore>();

  TaskAddButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          formKey.currentState?.save();
          final task = _inputService.getNewTask();
          Navigator.pop(context);
          _taskService.create(task);
        }
      },
      child: const Text('Add Task'),
    );
  }
}
