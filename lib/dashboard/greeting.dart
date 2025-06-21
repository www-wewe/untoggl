import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/services/firebase_service.dart';
import 'package:untoggl_project/common/widgets/handling_stream_builder.dart';

class Greeting extends StatelessWidget {
  final _authService = GetIt.instance.get<FirebaseService>();

  Greeting({super.key});

  @override
  Widget build(BuildContext context) {
    return HandlingStreamBuilder(
      stream: _authService.user,
      builder: (context, snapshot) {
        final user = snapshot;
        final displayName = user?.displayName ?? "Anonymous";
        return Text(
          "Hello, $displayName!",
          style: Theme.of(context).textTheme.headlineLarge,
        );
      },
    );
  }
}
