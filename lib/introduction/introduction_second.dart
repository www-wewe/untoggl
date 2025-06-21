import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

PageViewModel introductionSecondPage(BuildContext context) {
  return PageViewModel(
    title: "Managing your time was never this easy "
        "- tailor your timers to your exact needs!",
    bodyWidget: Column(
      children: [
        _buildInfoRow(
          "Click the ",
          Icons.add,
          " button to start logging your tasks, ",
        ),
        _buildInfoRow(
          "or hit the ",
          Icons.edit,
          " button to modify existing ones.",
        ),
      ],
    ),
    image: const Center(child: Icon(Icons.access_alarm, size: 100)),
    decoration: const PageDecoration(
      titleTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 25.0),
      bodyTextStyle: TextStyle(fontSize: 20.0),
    ),
  );
}

Widget _buildInfoRow(String text, IconData icon, String trailingText) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Text(text),
      Icon(icon),
      Text(trailingText),
    ],
  );
}
