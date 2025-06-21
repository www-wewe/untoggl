import 'package:flutter/material.dart';
import 'package:untoggl_project/common/enums/filter_options.dart';
import 'package:untoggl_project/common/enums/sort_options.dart';
import 'package:untoggl_project/dashboard/dashboard_tasks/sort_button.dart';

class FilterRow extends StatefulWidget {
  final Function(FilterOption filter) onFilterChanged;
  final Function(SortOption sort) onSortChanged;

  const FilterRow({
    super.key,
    required this.onFilterChanged,
    required this.onSortChanged,
  });

  @override
  State<FilterRow> createState() => _FilterRowState();
}

class _FilterRowState extends State<FilterRow> {
  final List<FilterOption> _filters = FilterOption.values;
  List<bool> _filterSelection = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text('Filter: '),
        for (final filter in _filters)
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: FilterChip(
              label: Text(filter.label),
              selected: _filterSelection[_filters.indexOf(filter)],
              onSelected: (value) {
                setState(() {
                  _filterSelection =
                      List.generate(_filterSelection.length, (index) => false);
                  _filterSelection[_filters.indexOf(filter)] = true;
                  widget.onFilterChanged(filter);
                });
              },
            ),
          ),
        const Spacer(),
        SortButton(onSortChanged: widget.onSortChanged),
      ],
    );
  }
}
