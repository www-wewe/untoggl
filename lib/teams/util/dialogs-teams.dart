import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/enums/allowed_colors.dart';
import 'package:untoggl_project/common/services/local_services/join_service.dart';
import 'package:untoggl_project/common/services/local_services/user_input_service.dart';
import 'package:untoggl_project/common/services/newServices/service_team_store.dart';
import 'package:untoggl_project/teams/add_team/add_team_fields/team_color_picker.dart';
import 'package:untoggl_project/teams/team_view/admin_buttons/add_member.dart';
import 'package:untoggl_project/teams/team_view/user_list_pick.dart';
import 'package:untoggl_project/teams/util/teams_constants.dart';

final _teamService = GetIt.instance<ServiceTeamStore>();
final _joinService = GetIt.instance<JoinService>();
final _userInputService = GetIt.instance<UserInputService>();

void _showGenericDialog(
  BuildContext context,
  String title,
  Widget content,
  Function onConfirm,
  Function onCancel, {
  bool sizebox = true,
}) {
  // Clear User Input
  _userInputService.clear();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: sizebox
            ? SizedBox(
                height: 300,
                width: 300,
                child: content,
              )
            : content,
        actions: [
          TextButton(
            onPressed: () {
              onCancel();
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              _userInputService.showSnackbar(context, "Saved");
              Navigator.of(context).pop();
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  );
}

void showAddMemberDialog(BuildContext context, String teamId) {
  _showGenericDialog(
    context,
    DEFAULT_ADD_MEMBER_TEXT,
    const AddMember(),
    () {
      // Assign Members to the team
      final List<String> emails = _userInputService.personNames;
      _joinService.addTeamMembers(teamId, emails);
    },
    () {},
  );
}

void showRemoveMemberDialog(BuildContext context, String teamId) {
  _showGenericDialog(
    context,
    DEFAULT_REMOVE_MEMBER_TEXT,
    UserListPick(
      teamId: teamId,
    ),
    () {
      final List<String> ids = _userInputService.getSelectedPersonIds();
      _teamService.removeTeamMembers(teamId, ids);
    },
    () {},
  );
}

void showPromoteToAdminDialog(BuildContext context, String teamId) {
  _showGenericDialog(
    context,
    DEFAULT_PROMOTE_TO_ADMIN_TEXT,
    UserListPick(
      ignoreAdmins: true,
      teamId: teamId,
    ),
    () {
      final List<String> ids = _userInputService.getSelectedPersonIds();
      _teamService.promoteToAdmin(teamId, ids);
    },
    () {},
  );
}

void showRemoveAdminDialog(BuildContext context, String teamId) {
  _showGenericDialog(
    context,
    DEFAULT_REMOVE_ADMIN_TEXT,
    UserListPick(
      ignoreAdmins: true,
      showAll: true,
      teamId: teamId,
    ),
    () {
      final List<String> ids = _userInputService.getSelectedPersonIds();
      _teamService.removeAdmin(teamId, ids);
    },
    () {},
  );
}

void showDeleteTeamDialog(BuildContext context, String teamId) {
  _showGenericDialog(
    context,
    DEFAULT_DELETE_TEAM_TEXT,
    Text(DEFAULT_DELETE_TEAM_MESSAGE),
    () {
      _teamService.delete(teamId);
      Navigator.of(context).pop();
    },
    () {},
    sizebox: false,
  );
}

void showRemoveSpecificMemberDialog(
  BuildContext context,
  String teamId,
  String userId,
) {
  _showGenericDialog(
    context,
    DEFAULT_REMOVE_MEMBER_TEXT,
    const Text('Do you really want to remove this member?'),
    () {
      _teamService.removeTeamMembers(teamId, [userId]);
    },
    () {},
    sizebox: false,
  );
}

void showChangeTeamColorDialog(BuildContext context, String teamId) {
  _showGenericDialog(
    context,
    'Change team color',
    TeamColorPicker(),
    () {
      final AllowedColors color = _userInputService.teamColor;
      _teamService.updateColor(color, teamId);
    },
    () {},
    sizebox: false,
  );
}
