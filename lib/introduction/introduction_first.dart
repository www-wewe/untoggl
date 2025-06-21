import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:lottie/lottie.dart';

PageViewModel introductionFirstPage(BuildContext context) {
  return PageViewModel(
    title: "Welcome to Untoggl!",
    body:
        "Welcome to the app where you can track your activities with ease and precision. "
        "Get ready to boost your productivity by organizing your time effectively.\n"
        "Simplify your day, focus on what matters, and leave the timing to us!",
    image: Center(
      child: Lottie.asset(
        "assets/lottie/loader.json",
        height: MediaQuery.of(context).size.height * 0.3,
        fit: BoxFit.cover,
      ),
    ),
  );
}
