import 'package:flutter/material.dart';

class FormButton extends StatelessWidget {
  final VoidCallback onClick;
  final bool isLoading;
  final int selectedIndex;

  const FormButton({
    super.key,
    required this.isLoading,
    required this.selectedIndex,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CircularProgressIndicator();
    }
    return ElevatedButton(
      onPressed: () async {
        FocusManager.instance.primaryFocus?.unfocus();
        onClick();
      },
      child: Text(selectedIndex == 0 ? 'Sign In' : 'Sign Up'),
    );
  }
}
