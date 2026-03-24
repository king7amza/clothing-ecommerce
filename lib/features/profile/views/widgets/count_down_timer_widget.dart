import 'dart:async';
import 'package:flutter/material.dart';

class CountdownTimerWidget extends StatefulWidget {
  final int seconds;
  final VoidCallback? onFinished;

  const CountdownTimerWidget({
    super.key,
    required this.seconds,
    this.onFinished,
  });

  @override
  State<CountdownTimerWidget> createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  @override
  Widget build(BuildContext context) {
    final timerStream = Stream.periodic(
      const Duration(seconds: 1),
      (count) => widget.seconds - count,
    ).take(widget.seconds + 1);
    return StreamBuilder<int>(
      stream: timerStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text(
            widget.seconds.toString().padLeft(2, '0'),
            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          );
        }
        int remaining = snapshot.data!;
        if (remaining <= 0) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            widget.onFinished?.call();
          });
          return const Text(
            "00",
            style: TextStyle(
              color: Colors.red,
              fontSize: 32,
              fontWeight: FontWeight.bold,
            ),
          );
        }
        return Text(
          remaining.toString().padLeft(2, '0'),
          style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        );
      },
    );
  }

  @override
  void dispose() {
    debugPrint("🗑️ CountdownTimerWidget disposed!");
    super.dispose();
  }
}
