import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/models/team.dart';
import 'package:untoggl_project/common/services/local_services/user_input_service.dart';

class TaskTeamDropdown extends StatefulWidget {
  final List<Team> assignableTeams;
  final Team? assigned;

  const TaskTeamDropdown({
    super.key,
    required this.assignableTeams,
    required this.assigned,
  });

  @override
  State<TaskTeamDropdown> createState() => _TaskTeamDropdownState();
}

class _TaskTeamDropdownState extends State<TaskTeamDropdown> {
  final _inputService = GetIt.instance<UserInputService>();
  String? dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem<String>> list = _buildDropdown();
    _inputService.clear();

    if (widget.assigned != null) {
      setState(() {
        dropdownValue = widget.assigned?.id;
      });
    }

    return DropdownButtonFormField<String>(
      value: dropdownValue,
      decoration: const InputDecoration(
        labelText: 'Team',
      ),
      items: list,
      onChanged: (value) => _onChanged(value),
      onSaved: (value) => _onChanged(value),
    );
  }

  void _onChanged(String? value) {
    final teamId =
        widget.assignableTeams.indexWhere((element) => element.id == value);
    if (teamId == -1) {
      _inputService.taskTeamAssignment = null;
      return;
    }
    final teamModel = widget.assignableTeams[teamId];
    _inputService.taskTeamAssignment = teamModel;
  }

  List<DropdownMenuItem<String>> _buildDropdown() {
    final list = widget.assignableTeams.map((team) {
      return DropdownMenuItem<String>(
        value: team.id,
        child: Row(
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: team.teamColor.color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Text(team.name),
          ],
        ),
      );
    }).toList();

    // Add a null value to the list to allow the user to select no team
    list.insert(
      0,
      const DropdownMenuItem<String>(
        value: '',
        child: Text('No team'),
      ),
    );
    return list;
  }
}
