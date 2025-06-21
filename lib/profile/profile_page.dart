import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/services/firebase_service.dart';
import 'package:untoggl_project/common/widgets/handling_stream_builder.dart';
import 'package:untoggl_project/profile/anonymous_content.dart';
import 'package:untoggl_project/profile/logged_in_content.dart';

class ProfilePage extends StatelessWidget {
  final _authService = GetIt.instance.get<FirebaseService>();

  ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HandlingStreamBuilder(
      stream: _authService.user,
      builder: (context, snapshot) {
        final user = snapshot as User;

        return user.isAnonymous
            ? AnonymousContent(user: user)
            : LoggedInContent(user: user);
      },
    );
  }
}
