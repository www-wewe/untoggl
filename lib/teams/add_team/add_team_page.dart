import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/services/local_services/user_input_service.dart';
import 'package:untoggl_project/teams/add_team/add_team_fields/add_team_name_field.dart';
import 'package:untoggl_project/teams/add_team/add_team_fields/submit_team_button.dart';
import 'package:untoggl_project/teams/add_team/add_team_fields/team_color_picker.dart';

class AddTeamPage extends StatelessWidget {
  final String? teamId;
  final _inputService = GetIt.I<UserInputService>();

  AddTeamPage({super.key, this.teamId});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    _inputService.clear();

    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AddTeamNameField(formKey: formKey),
              const SizedBox(height: 10),
              const Text('Team Color'),
              TeamColorPicker(),
              SubmitTeamButton(formKey: formKey),
            ],
          ),
        ),
      ),
    );
  }
}
