import 'package:flutter/material.dart';

class CalendarViewChoose extends StatefulWidget {
  final Function(String view) onViewSelected;

  const CalendarViewChoose({super.key, required this.onViewSelected});

  @override
  State<CalendarViewChoose> createState() => _CalendarViewChooseState();
}

class _CalendarViewChooseState extends State<CalendarViewChoose> {
  final List<String> _calendarViews = ['Day', 'Week', 'Month'];
  int _selectedView = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        for (var i = 0; i < _calendarViews.length; i++)
          FilterChip(
            selected: _selectedView == i,
            onSelected: (bool value) {
              setState(() {
                _selectedView = i;
                widget.onViewSelected(_calendarViews[i]);
              });
            },
            label: Text(_calendarViews[i]),
          ),
      ],
    );
  }
}
