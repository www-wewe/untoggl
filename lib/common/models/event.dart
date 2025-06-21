import 'dart:ui';

class Event {
  final String id;
  final String title;
  final String description;
  final Color color;

  const Event({
    required this.id,
    required this.title,
    required this.color,
    this.description = '',
  });
}
