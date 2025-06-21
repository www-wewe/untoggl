import 'package:flutter/material.dart';
import 'package:untoggl_project/common/widgets/handling_future_builder.dart';
import 'package:untoggl_project/teams/util/dialogs-teams.dart';

class AdminControls extends StatelessWidget {
  final String teamId;
  final Future<bool> isUserAdmin;

  const AdminControls({
    super.key,
    required this.teamId,
    required this.isUserAdmin,
  });

  @override
  Widget build(BuildContext context) {
    return HandlingFutureBuilder(
      future: isUserAdmin,
      builder: (context, snapshot) {
        final isUserAdmin = snapshot.data as bool;
        if (!isUserAdmin) {
          return const SizedBox.shrink();
        }
        return Column(
          children: [
            const Text('Admin controls'),
            Wrap(
              spacing: 10,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Show dialog to add member by email
                    showAddMemberDialog(context, teamId);
                  },
                  child: const Text('Add member'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Show dialog to remove member by email
                    showRemoveMemberDialog(context, teamId);
                  },
                  child: const Text('Remove member'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Show dialog to promote member to admin
                    showPromoteToAdminDialog(context, teamId);
                  },
                  child: const Text('Add admin'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Show dialog to remove admin
                    showRemoveAdminDialog(context, teamId);
                  },
                  child: const Text('Remove Admin'),
                ),
              ],
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                // Show dialog to delete team
                showDeleteTeamDialog(context, teamId);
              },
              child: const Text('Delete team'),
            ),
          ],
        );
      },
    );
  }
}
