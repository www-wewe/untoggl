import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/models/team.dart';
import 'package:untoggl_project/common/services/newServices/service_team_store.dart';
import 'package:untoggl_project/common/widgets/handling_stream_builder.dart';
import 'package:untoggl_project/task/form_inputs/task_team_dropdown.dart';

class TaskAssignToTeam extends StatelessWidget {
  final String taskId;
  final Team? assignedTo;
  final _teamsStore = GetIt.instance<ServiceTeamStore>();

  TaskAssignToTeam({super.key, required this.taskId, required this.assignedTo});

  @override
  Widget build(BuildContext context) {
    return HandlingStreamBuilder(
      stream: _teamsStore.getUsersTeams,
      builder: (context, snapshot) {
        final teams = snapshot;
        return TaskTeamDropdown(assignableTeams: teams, assigned: assignedTo);
      },
    );
  }
}
