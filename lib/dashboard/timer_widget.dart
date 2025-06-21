import 'dart:async';

import 'package:flutter/material.dart';

class TimerWidget extends StatefulWidget {
  final DateTime start;
  final DateTime end;
  final VoidCallback onTaskEnd;

  const TimerWidget({
    super.key,
    required this.start,
    required this.end,
    required this.onTaskEnd,
  });

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
  Duration _duration = Duration.zero;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final diff = DateTime.now().difference(widget.start);
      if (diff.inSeconds > widget.end.difference(widget.start).inSeconds) {
        widget.onTaskEnd();
        timer.cancel();
        return;
      }
      setState(() {
        _duration = diff;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hours = _duration.inHours.toString().padLeft(2, '0');
    final minutes = (_duration.inMinutes % 60).toString().padLeft(2, '0');
    final seconds = (_duration.inSeconds % 60).toString().padLeft(2, '0');

    final output = '$hours:$minutes:$seconds';
    return Text(output, style: Theme.of(context).textTheme.headlineSmall);
  }
}
