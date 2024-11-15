// lib/widgets/habit_card.dart

import 'package:flutter/material.dart';

import '../data/habit.dart';

class HabitCard extends StatelessWidget {
  final Habit habit;
  final Function onEdit;
  final Function onDelete;

  const HabitCard({
    required this.habit,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      child: ListTile(
        title: Text(habit.name),
        subtitle: Text('Target: ${habit.goal} times'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('${habit.completedCount}/${habit.goal}'),
            Text('${(habit.completedCount / habit.goal * 100).toStringAsFixed(1)}%'),
          ],
        ),
        onTap: () => onEdit(),
        onLongPress: () => onDelete(),
      ),
    );
  }
}
