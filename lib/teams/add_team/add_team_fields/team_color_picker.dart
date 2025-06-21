import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get_it/get_it.dart';
import 'package:untoggl_project/common/enums/allowed_colors.dart';
import 'package:untoggl_project/common/services/local_services/user_input_service.dart';

class TeamColorPicker extends StatelessWidget {
  final _inputService = GetIt.instance<UserInputService>();

  TeamColorPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlockPicker(
      availableColors: AllowedColors.values.map((e) => e.color).toList(),
      pickerColor: _inputService.teamColor.color,
      onColorChanged: (color) {
        _inputService.teamColor = AllowedColors.values
            .firstWhere((element) => element.color == color);
      },
    );
  }
}
