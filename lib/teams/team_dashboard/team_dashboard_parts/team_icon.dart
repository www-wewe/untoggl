import 'package:flutter/material.dart';
import 'package:untoggl_project/common/models/team.dart';

class TeamViewColor extends StatelessWidget {
  final Team team;

  const TeamViewColor({
    super.key,
    required this.team,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(Icons.circle, color: team.teamColor.color);
  }
}
