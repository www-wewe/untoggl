import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/services/local_services/user_input_service.dart';

class EditName extends StatelessWidget {
  final String defaultName;
  final _inputService = GetIt.instance.get<UserInputService>();

  EditName({
    super.key,
    required this.defaultName,
  });

  @override
  Widget build(BuildContext context) {
    _inputService.userName = defaultName;

    return TextField(
      decoration: const InputDecoration(labelText: 'Name'),
      controller: TextEditingController(text: defaultName),
      onChanged: (value) => _inputService.userName = value,
    );
  }
}
