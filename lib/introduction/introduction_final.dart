import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

PageViewModel introductionFinalPage(BuildContext context) {
  return PageViewModel(
    title: "Ready to make the most of your time?",
    body:
        "Do you want to keep your tasks synchronized across all your devices? "
        "Create an account and start logging your tasks today!",
    useRowInLandscape: true,
    image: const Center(
      child: Text("👋", style: TextStyle(fontSize: 100.0)),
    ),
    decoration: const PageDecoration(
      titleTextStyle: TextStyle(color: Colors.purpleAccent, fontSize: 20.0),
      bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
    ),
  );
}
