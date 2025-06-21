import 'package:flutter/material.dart';
import 'package:untoggl_project/common/models/event.dart';

Widget multiDayTileBuilder(event, tileConfiguration) {
  final e = event.eventData as Event;
  return Container(
    color: e.color,
    child: Text(e.title),
  );
}
