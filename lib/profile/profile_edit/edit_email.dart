import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/services/local_services/user_input_service.dart';

class EditEmail extends StatelessWidget {
  final bool isEmailVerified;
  final String defaultEmail;
  final _inputService = GetIt.instance.get<UserInputService>();

  EditEmail({
    super.key,
    required this.defaultEmail,
    this.isEmailVerified = false,
  });

  @override
  Widget build(BuildContext context) {
    _inputService.userEmail = defaultEmail;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (!isEmailVerified)
          const Text(
            "Email is not verified, email cannot be changed until it is verified.",
            style: TextStyle(color: Colors.red),
          ),
        const SizedBox(height: 12),
        TextField(
          decoration: const InputDecoration(labelText: 'Email'),
          controller: TextEditingController(text: defaultEmail),
          onChanged: (value) => _inputService.userEmail = value,
          readOnly: !isEmailVerified,
        ),
      ],
    );
  }
}
