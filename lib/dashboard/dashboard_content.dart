import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untoggl_project/dashboard/currently_working_on.dart';
import 'package:untoggl_project/dashboard/dashboard_tasks.dart';
import 'package:untoggl_project/dashboard/greeting.dart';

import 'dashboard_calendar.dart';

class DashboardContent extends StatefulWidget {
  const DashboardContent({super.key});

  @override
  State<DashboardContent> createState() => _DashboardContentState();
}

class _DashboardContentState extends State<DashboardContent> {
  DateTime _selectedDate =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Greeting(),
                CurrentlyWorkingOn(),
                const Divider(),
                DashboardCalendar(
                  onDaySelected: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                  selectedDate: _selectedDate,
                ),
                const Divider(),
                DashboardTasks(selectedDate: _selectedDate),
              ],
            ),
          ),
        ),
        _buildBottomButtonBar(context),
      ],
    );
  }

  SizedBox _buildBottomButtonBar(BuildContext context) {
    if (MediaQuery.of(context).size.width > 600) {
      return const SizedBox.shrink();
    }
    return SizedBox(
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildButton(context, Icons.calendar_today, '/calendar'),
          _buildButton(context, Icons.add, '/tasks/add'),
          _buildButton(context, Icons.people, '/teams'),
        ],
      ),
    );
  }

  ElevatedButton _buildButton(
    BuildContext context,
    IconData icon,
    String route,
  ) {
    return ElevatedButton(
      onPressed: () => context.push(route),
      child: Icon(icon),
    );
  }
}
