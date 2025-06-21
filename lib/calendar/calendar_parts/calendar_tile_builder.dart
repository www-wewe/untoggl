import 'package:flutter/material.dart';
import 'package:untoggl_project/common/models/event.dart';

Widget calendarTileBuilder(event, tileConfiguration) {
  final e = event.eventData as Event;
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      decoration: BoxDecoration(
        color: e.color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(e.title),
      ),
    ),
  );
}
