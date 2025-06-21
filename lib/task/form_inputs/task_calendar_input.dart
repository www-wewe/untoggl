import 'package:datetime_picker_formfield_new/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:untoggl_project/common/services/local_services/user_input_service.dart';
import 'package:untoggl_project/task/util/task_constants.dart';

class TaskCalendarInput extends StatelessWidget {
  final DateTime taskDate;
  final _inputService = GetIt.instance<UserInputService>();

  TaskCalendarInput({super.key, required this.taskDate});

  @override
  Widget build(BuildContext context) {
    _inputService.startsAt = taskDate;

    return DateTimeField(
      initialValue: taskDate,
      format: DateFormat("yyyy-MM-dd HH:mm"),
      validator: (value) =>
          value == null ? 'Please enter task start date' : null,
      decoration: InputDecoration(
        labelText: DEFAULT_TASK_CALENDAR,
        icon: const Icon(Icons.edit_calendar),
      ),
      onSaved: (value) => _inputService.startsAt = value!,
      onShowPicker: _pickDateTime,
    );
  }

  Future<DateTime?> _pickDateTime(context, currentValue) async {
    return await showDatePicker(
      context: context,
      firstDate: DateTime(1900),
      initialDate: currentValue ?? DateTime.now(),
      lastDate: DateTime(2100),
    ).then((DateTime? date) async {
      if (date != null) {
        final time = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
        );
        return DateTimeField.combine(date, time);
      } else {
        return currentValue;
      }
    });
  }
}
