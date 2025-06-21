import 'package:flutter/material.dart';
import 'package:untoggl_project/common/models/team.dart';

class TeamIcon extends StatelessWidget {
  final Team? taskTeam;

  const TeamIcon({super.key, required this.taskTeam});

  @override
  Widget build(BuildContext context) {
    if (taskTeam == null) {
      return const Icon(Icons.circle_outlined);
    }
    return Column(
      children: [
        Text(taskTeam!.name, style: const TextStyle(fontSize: 10)),
        Icon(Icons.circle, color: taskTeam!.teamColor.color),
      ],
    );
  }
}
