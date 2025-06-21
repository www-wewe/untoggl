import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untoggl_project/calendar/calendar_page.dart';
import 'package:untoggl_project/common/widgets/top_level_page.dart';
import 'package:untoggl_project/dashboard/dashboard_page.dart';
import 'package:untoggl_project/introduction/intro_page.dart';
import 'package:untoggl_project/onboarding/onboarding_page.dart';
import 'package:untoggl_project/profile/profile_page.dart';
import 'package:untoggl_project/settings/settings_page.dart';
import 'package:untoggl_project/task/add_task_page.dart';
import 'package:untoggl_project/teams/add_team/add_team_page.dart';
import 'package:untoggl_project/teams/team_dashboard/teams_page.dart';
import 'package:untoggl_project/teams/team_view/team_view.dart';
import 'package:untoggl_project/web_layout/web_layout_appbar.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final webRoutes = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/intro',
  routes: [
    GoRoute(
      path: '/intro',
      pageBuilder: (context, state) => _buildPage(IntroPage()),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => _buildPage(const OnboardingPage()),
    ),
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return WebLayoutAppbar(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (BuildContext context, GoRouterState state) =>
              const DashboardPage(),
        ),
        GoRoute(
          path: '/dash',
          builder: (BuildContext context, GoRouterState state) =>
              const DashboardPage(),
        ),
        GoRoute(
          path: '/tasks',
          builder: (context, state) => const Text("Tasks"),
          routes: [
            GoRoute(
              path: 'add',
              builder: (BuildContext context, GoRouterState state) =>
                  AddTaskPage(),
            ),
            GoRoute(
              path: ':taskId',
              builder: (BuildContext context, GoRouterState state) =>
                  AddTaskPage(taskId: state.pathParameters['taskId']!),
            ),
            GoRoute(
              path: 'date',
              builder: (BuildContext context, GoRouterState state) =>
                  AddTaskPage(customStartDate: true),
            ),
          ],
        ),
        GoRoute(
          path: '/teams',
          builder: (BuildContext context, GoRouterState state) =>
              const TeamsPage(),
          routes: [
            GoRoute(
              path: 'add',
              builder: (BuildContext context, GoRouterState state) =>
                  AddTeamPage(),
            ),
            GoRoute(
              path: ':teamId',
              builder: (BuildContext context, GoRouterState state) =>
                  TeamView(teamId: state.pathParameters['teamId']!),
            ),
          ],
        ),
        GoRoute(
          path: '/profile',
          builder: (BuildContext context, GoRouterState state) => ProfilePage(),
        ),
        GoRoute(
          path: '/settings',
          builder: (BuildContext context, GoRouterState state) =>
              SettingsPage(),
        ),
        GoRoute(
          path: '/calendar',
          builder: (BuildContext context, GoRouterState state) =>
              CalendarPage(),
        ),
      ],
    ),
  ],
);

final routes = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      pageBuilder: (context, state) => _buildPageWithAppBar(
        const DashboardPage(),
        _dashBoardAppBar(context),
      ),
    ),
    GoRoute(
      path: '/intro',
      pageBuilder: (context, state) => _buildPage(IntroPage()),
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) => _buildPage(const OnboardingPage()),
    ),
    GoRoute(
      path: '/dash',
      pageBuilder: (context, state) => _buildPageWithAppBar(
        const DashboardPage(),
        _dashBoardAppBar(context),
      ),
    ),
    GoRoute(
      path: '/profile',
      pageBuilder: (context, state) =>
          _buildPageWithTitle(ProfilePage(), "Profile"),
    ),
    GoRoute(
      path: '/settings',
      pageBuilder: (context, state) =>
          _buildPageWithTitle(SettingsPage(), "Settings"),
    ),
    GoRoute(
      path: '/teams',
      pageBuilder: (context, state) =>
          _buildPageWithTitle(const TeamsPage(), "Teams"),
      routes: [
        GoRoute(
          path: 'add',
          pageBuilder: (context, state) =>
              _buildPageWithTitle(AddTeamPage(), "Add Team"),
        ),
        GoRoute(
          path: ":teamId",
          pageBuilder: (context, state) => _buildPageWithTitle(
            TeamView(teamId: state.pathParameters['teamId']!),
            "Team",
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/tasks',
      builder: (context, state) => const Text("Tasks"),
      routes: [
        GoRoute(
          path: 'add',
          pageBuilder: (context, state) =>
              _buildPageWithTitle(AddTaskPage(), "Add Task"),
        ),
        GoRoute(
          path: 'date',
          pageBuilder: (context, state) => _buildPageWithTitle(
            AddTaskPage(customStartDate: true),
            "Add Task",
          ),
        ),
        GoRoute(
          path: ':taskId',
          pageBuilder: (context, state) => _buildPageWithTitle(
            AddTaskPage(taskId: state.pathParameters['taskId']!),
            "Task Details",
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/calendar',
      pageBuilder: (context, state) =>
          _buildPageWithTitle(CalendarPage(), "Calendar"),
    ),
  ],
);

// Helper Widgets
MaterialPage _buildPage(Widget child) {
  return MaterialPage(child: TopLevelPage(child: child));
}

MaterialPage _buildPageWithTitle(Widget child, String title) {
  return MaterialPage(
    child: TopLevelPage(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
      ),
      child: child,
    ),
  );
}

MaterialPage _buildPageWithAppBar(Widget child, AppBar appBar) {
  return MaterialPage(
    child: TopLevelPage(
      appBar: appBar,
      child: child,
    ),
  );
}

// Constant AppBars
AppBar _dashBoardAppBar(BuildContext context) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(Icons.person),
      onPressed: () {
        context.push('/profile');
      },
    ),
    centerTitle: true,
    title: const Text("Dashboard"),
    actions: [
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          context.push('/settings');
        },
      ),
    ],
  );
}
