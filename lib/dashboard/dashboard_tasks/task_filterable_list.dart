import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:untoggl_project/common/enums/sort_options.dart';
import 'package:untoggl_project/common/models/task.dart';
import 'package:untoggl_project/dashboard/dashboard_tasks/filter_row.dart';
import 'package:untoggl_project/dashboard/dashboard_tasks/team_icon.dart';

import '../../common/enums/filter_options.dart';

class TaskFilterableList extends StatefulWidget {
  final List<Task> tasks;

  const TaskFilterableList({
    super.key,
    required this.tasks,
  });

  @override
  State<TaskFilterableList> createState() => _TaskFilterableListState();
}

class _TaskFilterableListState extends State<TaskFilterableList> {
  List<Task> shownTasks = [];
  FilterOption _filter = FilterOption.all;
  SortOption _sort = SortOption.time;

  @override
  void initState() {
    super.initState();
    shownTasks = widget.tasks; // Initially, show all tasks
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FilterRow(
          onFilterChanged: (filter) {
            setState(() {
              _filter = filter;
            });
          },
          onSortChanged: (sort) {
            setState(() {
              _sort = sort;
            });
          },
        ),
        _buildTaskList(),
      ],
    );
  }

  Widget _buildTaskList() {
    _applySort(_sort);
    shownTasks = _applyFilters(_filter);
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: ListView.builder(
        itemCount: shownTasks.length,
        itemBuilder: (context, index) {
          final task = shownTasks[index];
          return ListTile(
            title: Text(task.name),
            subtitle: Text(task.description),
            leading: task.completed
                ? const Icon(Icons.check_box)
                : const Icon(Icons.check_box_outline_blank),
            trailing: TeamIcon(taskTeam: task.assignedTeam),
            onTap: () {
              context.push('/tasks/${task.id}');
            },
          );
        },
      ),
    );
  }

  List<Task> _applyFilters(FilterOption filter) {
    return widget.tasks.where((task) {
      switch (filter) {
        case FilterOption.all:
          return true;
        case FilterOption.done:
          return task.completed;
        case FilterOption.upcoming:
          return !task.completed;
        default:
          return true;
      }
    }).toList();
  }

  void _applySort(SortOption sort) {
    widget.tasks.sort((task1, task2) {
      switch (sort) {
        case SortOption.time:
          return task1.startsAt.compareTo(task2.startsAt);
        case SortOption.name:
          return task1.name.compareTo(task2.name);
        case SortOption.team:
          return _compareByTeam(task1, task2);
        default:
          return task1.startsAt.compareTo(task2.startsAt);
      }
    });
  }
}

int _compareByTeam(Task task1, Task task2) {
  final a = task1.assignedTeam;
  final b = task2.assignedTeam;
  if (a == null && b == null) {
    return 0;
  } else if (a == null) {
    return 1;
  } else if (b == null) {
    return -1;
  } else {
    return a.name.compareTo(b.name);
  }
}
