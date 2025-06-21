import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WebLayoutButton extends StatelessWidget {
  const WebLayoutButton({super.key});

  @override
  Widget build(BuildContext context) {
    final path = GoRouterState.of(context).uri.path;

    return FloatingActionButton(
      onPressed: () {
        switch (path) {
          case "/dash":
            context.go('/tasks/add');
            break;
          case "/teams":
            context.go('/teams/add');
            break;
          case "/calendar":
            context.go('/tasks/add');
            break;
          default:
            break;
        }
      },
      child: const Icon(Icons.add),
    );
  }
}
