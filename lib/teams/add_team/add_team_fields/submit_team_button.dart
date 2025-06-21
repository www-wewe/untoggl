import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/services/local_services/user_input_service.dart';
import 'package:untoggl_project/common/services/newServices/service_team_store.dart';
import 'package:untoggl_project/common/utils.dart';
import 'package:untoggl_project/teams/util/teams_constants.dart';

class SubmitTeamButton extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final _teamService = GetIt.I<ServiceTeamStore>();
  final _inputService = GetIt.I<UserInputService>();

  SubmitTeamButton({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        if (formKey.currentState!.validate()) {
          formKey.currentState?.save();
          Navigator.pop(context);
          final createTeam = emptyTeam().copyWith(
            name: _inputService.teamName,
            teamColor: _inputService.teamColor,
          );
          await _teamService.create(createTeam);
        }
      },
      child: Text(DEFAULT_TEAM_SUBMIT),
    );
  }
}
