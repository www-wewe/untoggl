import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/services/local_services/user_input_service.dart';

class AddTeamNameField extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final _inputService = GetIt.I<UserInputService>();

  AddTeamNameField({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: '',
      decoration:
          const InputDecoration(labelText: 'Team Name', icon: Icon(Icons.edit)),
      onSaved: (value) => _inputService.teamName = value!,
      validator: (value) => value!.isEmpty ? 'Please enter team name' : null,
    );
  }
}
