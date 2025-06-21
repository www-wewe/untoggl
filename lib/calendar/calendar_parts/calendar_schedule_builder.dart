import 'package:flutter/material.dart';
import 'package:untoggl_project/common/models/event.dart';

Widget scheduleTileBuilder(event, date) {
  final e = event as Event;
  return Text(e.title);
}
