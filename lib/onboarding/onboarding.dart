import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untoggl_project/common/services/firebase_service.dart';
import 'package:untoggl_project/common/services/newServices/service_settings_store.dart';
import 'package:untoggl_project/common/utils.dart';
import 'package:untoggl_project/onboarding/form_button.dart';
import 'package:untoggl_project/onboarding/form_input.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _Onboarding();
}

class _Onboarding extends State<Onboarding> {
  int _selectedIndex = 0; // Default to Login, 1 is Sign Up
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordValidationController = TextEditingController();
  final _authService = GetIt.instance<FirebaseService>();
  final _settingService = GetIt.instance<ServiceSettingsStore>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () async {
                final sp = await SharedPreferences.getInstance();
                await sp.setBool("firstRun", false);
                if (!context.mounted) return;
                context.go('/dash');
              },
              icon: const Icon(Icons.close),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('UnToggl', style: TextStyle(fontSize: 32)),
            const Text('Time tracking for individuals and teams'),
            const SizedBox(height: 20),
            _buildToggleTab(),
            const SizedBox(height: 20),
            FormInput(
              label: 'Email',
              onChanged: (value) => _emailController.text = value,
            ),
            const SizedBox(height: 10),
            FormInput(
              label: 'Password',
              obscureText: true,
              onChanged: (value) => _passwordController.text = value,
            ),
            const SizedBox(height: 10),
            if (_selectedIndex == 1)
              FormInput(
                label: 'Confirm Password',
                obscureText: true,
                onChanged: (value) =>
                    _passwordValidationController.text = value,
              ),
            const SizedBox(height: 10),
            FormButton(
              isLoading: _isLoading,
              selectedIndex: _selectedIndex,
              onClick: () async {
                setState(() => _isLoading = true);
                await handleAuth(context);
                setState(() => _isLoading = false);
              },
            ),
            if (_selectedIndex == 0) _buildSignUpPrompt(),
          ],
        ),
      ],
    );
  }

  Row _buildSignUpPrompt() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t have an account?'),
        TextButton(
          onPressed: () {
            setState(() {
              _selectedIndex = 1;
            });
          },
          child: const Text('Sign Up'),
        ),
      ],
    );
  }

  FlutterToggleTab _buildToggleTab() {
    return FlutterToggleTab(
      width: 90,
      borderRadius: 30,
      height: 40,
      selectedIndex: _selectedIndex,
      selectedTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w700,
      ),
      unSelectedTextStyle: const TextStyle(
        color: Colors.black87,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
      labels: const ["Login", "Sign Up"],
      selectedLabelIndex: (index) {
        setState(() {
          _selectedIndex = index;
        });
      },
    );
  }

  Future<void> handleAuth(
    BuildContext context,
  ) async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final validation = _passwordValidationController.text;

    try {
      final sp = await SharedPreferences.getInstance();
      if (_selectedIndex == 0) {
        await _authService.signInWithEmailAndPassword(email, password);
      } else {
        await _authService.signUpWithEmailAndPassword(
          email,
          password,
          validation,
        );

        final userSettings = emptyUserSettings().copyWith(
          email: email,
        );
        await _settingService.create(userSettings);
      }
      await sp.setBool("firstRun", false);
      if (!context.mounted) return;
      context.go('/intro');
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }
}
