// lib/widgets/progress_indicator.dart

import 'package:flutter/material.dart';

class ProgressIndicatorWidget extends StatelessWidget {
  final int completed;
  final int goal;

  ProgressIndicatorWidget({required this.completed, required this.goal});

  @override
  Widget build(BuildContext context) {
    double progress = (completed / goal) * 100;
    return Column(
      children: [
        LinearProgressIndicator(value: progress / 100),
        Text('${completed}/$goal (${progress.toStringAsFixed(1)}%)'),
      ],
    );
  }
}
