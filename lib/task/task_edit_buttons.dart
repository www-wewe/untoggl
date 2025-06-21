import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:untoggl_project/common/services/local_services/user_input_service.dart';
import 'package:untoggl_project/common/services/newServices/service_task_store.dart';
import 'package:untoggl_project/common/utils.dart';

class TaskEditButtons extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final String taskId;
  final _inputService = GetIt.instance<UserInputService>();
  final _taskService = GetIt.instance<ServiceTaskStore>();

  TaskEditButtons({
    super.key,
    required this.formKey,
    required this.taskId,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildDeleteButton(context),
        const SizedBox(height: 10),
        _buildUpdateButton(context),
      ],
    );
  }

  Widget _buildDeleteButton(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      ),
      onPressed: () => _deleteTask(context),
      child: const Text('Delete Task'),
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _updateTask(context),
      child: const Text('Update Task'),
    );
  }

  void _deleteTask(BuildContext context) {
    _taskService.delete(taskId);
    context.go("/dash");
  }

  void _updateTask(BuildContext context) {
    if (formKey.currentState!.validate()) {
      formKey.currentState?.save();
      context.pop("/dash");
      final userId = _taskService.firebase.userId;
      final updateTask = _inputService.getNewTask();
      final task = emptyTask().copyWith(
        id: taskId,
        name: updateTask.name,
        description: updateTask.description,
        startsAt: updateTask.startsAt,
        endsAt: updateTask.endsAt,
        completed: updateTask.completed,
        userId: userId,
        assignedTeam: updateTask.assignedTeam,
      );
      _taskService.update(task);
    }
  }
}
