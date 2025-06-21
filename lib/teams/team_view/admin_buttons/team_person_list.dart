import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/models/user_settings.dart';
import 'package:untoggl_project/common/services/newServices/service_settings_store.dart';
import 'package:untoggl_project/common/services/newServices/service_team_store.dart';
import 'package:untoggl_project/common/widgets/handling_future_builder.dart';
import 'package:untoggl_project/teams/util/dialogs-teams.dart';

class TeamPersonList extends StatelessWidget {
  final String teamId;
  final List<String> list;
  final Future<bool> isUserAdmin;
  final _teamService = GetIt.instance<ServiceTeamStore>();
  final _settingsService = GetIt.instance<ServiceSettingsStore>();

  TeamPersonList({
    super.key,
    required this.teamId,
    required this.list,
    required this.isUserAdmin,
  });

  @override
  Widget build(BuildContext context) {
    if (list.isEmpty) {
      return const Text("No members");
    }

    return HandlingFutureBuilder(
      future: isUserAdmin,
      builder: (context, snapshot) {
        final isUserAdmin = snapshot.data ?? false;

        return ListView.builder(
          itemCount: list.length,
          shrinkWrap: true, // Removed fixed height computation
          itemBuilder: (context, index) {
            return _buildListItem(context, list[index], isUserAdmin);
          },
        );
      },
    );
  }

  Widget _buildListItem(
    BuildContext context,
    String personId,
    bool isUserAdmin,
  ) {
    final userId = _teamService.firebase.userId;

    return ListTile(
      leading: CircleAvatar(
        child: _loadPhoto(personId),
      ),
      title: _personName(personId),
      subtitle: Text(personId),
      trailing: isUserAdmin && personId != userId
          ? IconButton(
              icon: const Icon(Icons.remove),
              onPressed: () {
                showRemoveSpecificMemberDialog(context, teamId, personId);
              },
            )
          : const SizedBox.shrink(),
    );
  }

  _personName(String personId) {
    final userSettings = _settingsService.getByUserIdSync(personId);

    return HandlingFutureBuilder(
      future: userSettings,
      builder: (context, snapshot) {
        final settings = snapshot.data as UserSettings;
        return Text(settings.email);
      },
    );
  }

  _loadPhoto(String personId) {
    final photo = _settingsService.getByUserIdSync(personId);

    return HandlingFutureBuilder(
      future: photo,
      builder: (context, snapshot) {
        final settings = snapshot.data as UserSettings;
        if (settings.photoUrl == null) {
          return const CircleAvatar(
            child: Icon(Icons.person),
          );
        }
        return CircleAvatar(
          backgroundImage: NetworkImage(settings.photoUrl!),
        );
      },
    );
  }
}
