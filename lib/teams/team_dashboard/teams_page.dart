import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untoggl_project/teams/team_dashboard/team_list_generic.dart';

class TeamsPage extends StatelessWidget {
  const TeamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Text('Teams (Admin)', style: TextStyle(fontSize: 20)),
          TeamListGeneric(adminList: true),
          const Text('Teams (User)', style: TextStyle(fontSize: 20)),
          TeamListGeneric(),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  context.push('/teams/add');
                },
                child: const Text('Add team'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
