import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/models/team.dart';
import 'package:untoggl_project/common/services/firebase_service.dart';
import 'package:untoggl_project/common/services/local_services/user_input_service.dart';
import 'package:untoggl_project/common/services/newServices/service_team_store.dart';
import 'package:untoggl_project/common/widgets/handling_stream_builder.dart';
import 'package:untoggl_project/teams/team_view/admin_buttons/person_picker.dart';
import 'package:untoggl_project/teams/util/teams_constants.dart';

class UserListPick extends StatelessWidget {
  final String teamId;
  final bool ignoreAdmins;
  final bool showAll;
  final _inputService = GetIt.instance<UserInputService>();
  final _authService = GetIt.instance<FirebaseService>();
  final _teamService = GetIt.instance<ServiceTeamStore>();

  UserListPick({
    super.key,
    required this.teamId,
    this.ignoreAdmins = false,
    this.showAll = false,
  });

  @override
  Widget build(BuildContext context) {
    return HandlingStreamBuilder<Team>(
      stream: _teamService.getById(teamId),
      builder: (context, team) {
        if (team.memberIds.isEmpty) {
          return Text(DEFAULT_NO_MEMBERS);
        }

        final currentUserId = _authService.userId;
        final pickers = ignoreAdmins
            ? team.memberIds
            : team.memberIds
                .where((element) => !team.adminIds.contains(element))
                .toList();
        // Cannot edit yourself
        if (!showAll) {
          pickers.remove(currentUserId);
        }
        if (pickers.isEmpty) {
          return Text(DEFAULT_NO_MEMBERS);
        }
        _inputService.initPickablePersons(pickers);
        return const PersonPicker();
      },
    );
  }
}
