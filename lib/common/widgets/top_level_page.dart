import 'package:flutter/material.dart';

class TopLevelPage extends StatelessWidget {
  final Widget child;
  final AppBar? appBar;

  const TopLevelPage({super.key, required this.child, this.appBar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: child,
      ),
    );
  }
}
