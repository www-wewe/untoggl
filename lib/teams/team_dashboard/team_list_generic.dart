import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:untoggl_project/common/models/team.dart';
import 'package:untoggl_project/common/services/newServices/service_team_store.dart';
import 'package:untoggl_project/common/utils.dart';
import 'package:untoggl_project/common/widgets/handling_stream_builder.dart';
import 'package:untoggl_project/teams/team_dashboard/team_dashboard_parts/team_icon.dart';
import 'package:untoggl_project/teams/util/teams_constants.dart';

class TeamListGeneric extends StatelessWidget {
  final bool adminList;
  final _teamService = GetIt.instance<ServiceTeamStore>();

  TeamListGeneric({
    super.key,
    this.adminList = false,
  });

  @override
  Widget build(BuildContext context) {
    final Stream<List<Team>> teamsStream = adminList
        ? _teamService.getWhereUserIsAdmin
        : _teamService.getWhereUserIsMember;

    return HandlingStreamBuilder<List<Team>>(
      stream: teamsStream,
      builder: (context, teams) {
        if (teams.isEmpty) {
          return Text(
            adminList ? DEFAULT_NO_ADMIN_TEXT : DEFAULT_NO_MEMBER_TEXT,
          );
        }
        return Column(
          children: [
            Text(adminList ? DEFAULT_ADMIN_TEXT : DEFAULT_MEMBER_TEXT),
            SizedBox(
              height: _calculateHeight(teams.length),
              child: ListView.builder(
                itemCount: teams.length,
                itemBuilder: (context, index) {
                  final team = teams[index];
                  return ListTile(
                    leading: const Icon(Icons.group),
                    title: Text(team.name),
                    subtitle: Text(trimToLength(team.id)),
                    trailing: TeamViewColor(team: team),
                    onLongPress: () {},
                    onTap: () {
                      context.push('/teams/${team.id}');
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  double _calculateHeight(int length) {
    return length > 4 ? 4 * 72.0 : length * 72.0;
  }
}
