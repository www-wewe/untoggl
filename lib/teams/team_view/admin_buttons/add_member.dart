import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:simple_chips_input/simple_chips_input.dart';
import 'package:untoggl_project/common/services/local_services/user_input_service.dart';

class AddMember extends StatefulWidget {
  const AddMember({super.key});

  @override
  State<AddMember> createState() => _AddMemberState();
}

class _AddMemberState extends State<AddMember> {
  final List<String> _selectedMails = [];
  final _inputService = GetIt.instance<UserInputService>();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: SimpleChipsInput(
        separatorCharacter: ',',
        validateInput: true,
        validateInputMethod: (String email) {
          // Match email to email regex
          final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
          if (!emailRegex.hasMatch(email)) {
            return 'Invalid email';
          }
          final contains = _selectedMails.contains(email);
          if (contains) {
            return 'Email already added';
          }
          return null;
        },
        onChipDeleted: (String email, int index) {
          setState(() {
            _selectedMails.remove(email);
          });
        },
        chipTextStyle: const TextStyle(color: Colors.black),
        textFormFieldStyle: TextFormFieldStyle(
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            hintText: 'Enter email',
          ),
        ),
        deleteIcon: const Icon(Icons.delete),
        autoFocus: true,
        placeChipsSectionAbove: false,
        onChipAdded: (String email) {
          if (_selectedMails.contains(email)) {
            return;
          }
          setState(() {
            _selectedMails.add(email.toLowerCase());
            _inputService.personNames = _selectedMails;
          });
        },
      ),
    );
  }
}
