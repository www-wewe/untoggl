import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:untoggl_project/profile/profile_edit/edit_email.dart';
import 'package:untoggl_project/profile/profile_edit/edit_name.dart';
import 'package:untoggl_project/profile/util/profile_dialogs.dart';

class LoggedInContent extends StatelessWidget {
  final User user;

  const LoggedInContent({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        _buildAvatar(context),
        _buildUserInfoTile(
          context: context,
          title: 'User ID',
          subtitle: user.uid,
          onTap: () => _copyToClipboard(context, user.uid),
        ),
        _buildEditableInfoTile(
          context: context,
          title: 'Name',
          subtitle: user.displayName ?? "No-name",
          icon: Icons.edit,
          editAction: () => showEditNameDialog(
            context,
            EditName(defaultName: user.displayName ?? "No-name"),
          ),
        ),
        _buildEditableInfoTile(
          context: context,
          title: 'Email',
          subtitle: user.email ?? "No-email",
          icon: Icons.edit,
          editAction: () => showEditEmailDialog(
            context,
            EditEmail(defaultEmail: user.email ?? "No-email"),
          ),
        ),
        _buildEditableInfoTile(
          context: context,
          title: 'Email verified',
          subtitle: user.emailVerified ? "Yes" : "No",
          icon: Icons.mail_lock_outlined,
          editAction: () => showVerifyEmailDialog(context),
        ),
        _buildEditableInfoTile(
          context: context,
          title: 'Password',
          subtitle: "********",
          icon: Icons.edit,
          editAction: () => showResetPassword(context),
        ),
        ListTile(
          title: ElevatedButton(
            onPressed: () => showLogoutConfirmation(context),
            child: const Text('Logout'),
          ),
        ),
      ],
    );
  }

  Widget _buildAvatar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => showEditPhotoDialog(context),
        child: Center(
          child: CircleAvatar(
            backgroundImage: user.photoURL != null
                ? NetworkImage(user.photoURL!)
                : const NetworkImage("https://picsum.photos/200"),
            radius: 50.0,
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      onTap: onTap,
    );
  }

  Widget _buildEditableInfoTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    VoidCallback? editAction,
  }) {
    return ListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: IconButton(
        icon: Icon(icon),
        onPressed: editAction,
      ),
    );
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Copied to clipboard'),
      ),
    );
  }
}
