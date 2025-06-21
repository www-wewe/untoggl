import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/models/team.dart';
import 'package:untoggl_project/common/services/newServices/service_team_store.dart';
import 'package:untoggl_project/common/utils.dart';
import 'package:untoggl_project/common/widgets/handling_stream_builder.dart';
import 'package:untoggl_project/teams/team_view/admin_buttons/admin_controls.dart';
import 'package:untoggl_project/teams/team_view/admin_buttons/team_person_list.dart';
import 'package:untoggl_project/teams/util/dialogs-teams.dart';

class TeamView extends StatelessWidget {
  final String teamId;
  final _teamsService = GetIt.instance<ServiceTeamStore>();

  TeamView({
    super.key,
    required this.teamId,
  });

  @override
  Widget build(BuildContext context) {
    final teamStream = _teamsService.getById(teamId);
    final isUserAdminStream = _teamsService.isUserAdmin(teamId);

    return HandlingStreamBuilder<Team>(
      stream: teamStream,
      builder: (context, team) {
        return Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(team.name, style: const TextStyle(fontSize: 30)),
                Text(
                  "(${trimToLength(team.id)})",
                  style: const TextStyle(fontSize: 10),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    showChangeTeamColorDialog(context, teamId);
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: team.teamColor.color,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text("Admins"),
                TeamPersonList(
                  list: team.adminIds,
                  isUserAdmin: isUserAdminStream,
                  teamId: teamId,
                ),
                const SizedBox(height: 10),
                const Text("Members"),
                TeamPersonList(
                  list: team.memberIds,
                  isUserAdmin: isUserAdminStream,
                  teamId: teamId,
                ),
                AdminControls(teamId: teamId, isUserAdmin: isUserAdminStream),
              ],
            ),
          ),
        );
      },
    );
  }
}
