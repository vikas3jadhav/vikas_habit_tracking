// lib/screens/habit_detail_screen.dart

import 'package:flutter/material.dart';

class HabitDetailScreen extends StatelessWidget {
  final int habitId;

  const HabitDetailScreen({super.key, required this.habitId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Habit $habitId Detail'),
      ),
      body: Center(
        child: Text('Details of Habit #$habitId'),
      ),
    );
  }
}
