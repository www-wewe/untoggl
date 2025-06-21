import 'package:flutter/material.dart';
import 'package:untoggl_project/web_layout/web_layout_button.dart';
import 'package:untoggl_project/web_layout/web_layout_sidebar.dart';

class WebLayoutAppbar extends StatelessWidget {
  final Widget child;

  const WebLayoutAppbar({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawerEnableOpenDragGesture: false,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('UnToggl'),
      ),
      floatingActionButton: const WebLayoutButton(),
      body: Row(
        children: [
          const WebLayoutSidebar(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Expanded(
                child: child,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
