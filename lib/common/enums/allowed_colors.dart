import 'package:flutter/material.dart';

enum AllowedColors {
  red(Colors.red),
  blue(Colors.blue),
  green(Colors.green),
  yellow(Colors.yellow),
  purple(Colors.purple),
  pink(Colors.pink),
  brown(Colors.brown);

  const AllowedColors(this.color);

  final Color color;

  int toJson() {
    return color.value;
  }
}
