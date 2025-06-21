import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:untoggl_project/common/services/firebase_service.dart';
import 'package:untoggl_project/common/services/local_services/storage_service.dart';
import 'package:untoggl_project/common/services/local_services/user_input_service.dart';

final _authService = GetIt.instance.get<FirebaseService>();
final _userInputService = GetIt.instance.get<UserInputService>();
final _storageService = GetIt.instance.get<StorageService>();

void _showGenericDialog(
  BuildContext context,
  String title,
  Widget content,
  Function onConfirm,
) {
  _userInputService.clear();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: content,
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              onConfirm();
              context.pop();
            },
            child: const Text('Confirm'),
          ),
        ],
      );
    },
  );
}

void showEditNameDialog(BuildContext context, Widget content) {
  _showGenericDialog(context, "Edit Name", content, () {
    context.pop();
    _authService.updateDisplayName(_userInputService.userName);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Name updated'),
      ),
    );
  });
}

void showEditEmailDialog(BuildContext context, Widget content) {
  _showGenericDialog(context, "Edit Email", content, () {
    if (_userInputService.userEmail != _authService.userName) {
      _authService.updateEmail(_userInputService.userEmail);
    }
    context.pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Email updated'),
      ),
    );
  });
}

void showVerifyEmailDialog(BuildContext context) {
  _showGenericDialog(context, "Verify Email",
      const Text("Are you sure you want to send a verification email?"), () {
    _authService.sendEmailVerification();
    context.pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Verification email sent, please check your inbox'),
      ),
    );
  });
}

void showResetPassword(BuildContext context) {
  _showGenericDialog(
      context,
      "Reset Password",
      const Text(
        "Your password will be reset by sending you an email with instructions.",
      ), () {
    _authService.sendPasswordResetEmail();
    context.pop();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Password reset email sent, please check your inbox'),
      ),
    );
  });
}

void showLogoutConfirmation(BuildContext context) {
  _showGenericDialog(
      context, "Logout", const Text("Are you sure you want to logout?"), () {
    _authService.signOut();
    context.pop();
  });
}

void showEditPhotoDialog(BuildContext context) {
  try {
    _storageService.pickAndUploadNewProfilePicture();
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(e.toString()),
      ),
    );
  }
}
