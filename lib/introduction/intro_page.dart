import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:untoggl_project/common/services/local_services/join_service.dart';
import 'package:untoggl_project/common/services/local_services/notification_service.dart';
import 'package:untoggl_project/common/widgets/handling_future_builder.dart';
import 'package:untoggl_project/introduction/introduction_final.dart';
import 'package:untoggl_project/introduction/introduction_first.dart';
import 'package:untoggl_project/introduction/introduction_second.dart';

class IntroPage extends StatelessWidget {
  final _joinService = GetIt.I.get<JoinService>();
  final _notificationService = GetIt.I.get<NotificationService>();

  IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return HandlingFutureBuilder(
      future: _joinService.showIntroductionScreen(),
      builder: (context, snapshot) {
        final shouldShowIntro = snapshot.data as bool;
        _initializeServices(context);
        if (!shouldShowIntro) {
          _navigateToDashboard(context);
          return const Center(child: CircularProgressIndicator());
        }
        return _buildIntroductionScreen(context);
      },
    );
  }

  void _initializeServices(BuildContext context) async {
    await _notificationService.init(context);
  }

  void _navigateToDashboard(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go('/dash');
    });
  }

  Widget _buildIntroductionScreen(BuildContext context) {
    final pages = [
      introductionFirstPage(context),
      introductionSecondPage(context),
      introductionFinalPage(context),
    ];

    if (MediaQuery.of(context).size.width < 600) {
      return IntroductionScreen(
        pages: pages,
        next: const Icon(Icons.arrow_forward),
        showNextButton: true,
        showSkipButton: true,
        skip: const Text("Skip"),
        done: const Text("Log in\nSign up"),
        onDone: () => context.go('/login'),
        dotsDecorator: const DotsDecorator(
          activeColor: Colors.purpleAccent,
        ),
      );
    }

    return Align(
      alignment: Alignment.center,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        child: IntroductionScreen(
          pages: pages,
          next: const Icon(Icons.arrow_forward),
          showNextButton: true,
          showSkipButton: true,
          skip: const Text("Skip"),
          done: const Text("Log in\nSign up"),
          onDone: () => context.go('/login'),
          dotsDecorator: const DotsDecorator(
            activeColor: Colors.purpleAccent,
          ),
        ),
      ),
    );
  }
}
