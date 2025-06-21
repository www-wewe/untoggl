import 'package:flutter/material.dart';
import 'package:untoggl_project/common/enums/sort_options.dart';

class SortButton extends StatefulWidget {
  final Function(SortOption sort) onSortChanged;

  const SortButton({
    super.key,
    required this.onSortChanged,
  });

  @override
  State<SortButton> createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {
  SortOption _selectedOption = SortOption.time;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(_selectedOption.label, style: const TextStyle(fontSize: 12)),
        PopupMenuButton(
          icon: const Icon(Icons.sort),
          itemBuilder: (context) {
            return SortOption.values
                .map(
                  (option) => PopupMenuItem(
                    value: option,
                    child: Text(option.label),
                  ),
                )
                .toList();
          },
          onSelected: (value) {
            setState(() {
              _selectedOption = value;
              widget.onSortChanged(_selectedOption);
            });
          },
        ),
      ],
    );
  }
}
