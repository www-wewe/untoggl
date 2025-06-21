import 'package:flutter/material.dart';

const _SETTINGS_CARD_HEIGHT = 60.0;
const _HORIZONTAL_GAP = 12.0;

class SettingsCard extends StatelessWidget {
  final String label;
  final Widget child;

  const SettingsCard({super.key, required this.label, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: _SETTINGS_CARD_HEIGHT,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Theme.of(context).colorScheme.primary),
        ),
        padding: const EdgeInsets.symmetric(horizontal: _HORIZONTAL_GAP),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label),
            child,
          ],
        ),
      ),
    );
  }
}
