import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/services/local_services/user_input_service.dart';
import 'package:untoggl_project/teams/team_view/admin_buttons/pickable_person_tile.dart';

class PersonPicker extends StatefulWidget {
  const PersonPicker({super.key});

  @override
  State<PersonPicker> createState() => _PersonPickerState();
}

class _PersonPickerState extends State<PersonPicker> {
  final _inputService = GetIt.instance<UserInputService>();

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _inputService.addListener(refresh);
    }
  }

  @override
  void dispose() {
    _inputService.removeListener(refresh);
    super.dispose();
  }

  void refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _inputService.pickablePersons.length,
      itemBuilder: (context, index) {
        final person = _inputService.pickablePersons[index];
        return PickablePersonTile(
          userId: person.id,
        );
      },
    );
  }
}
