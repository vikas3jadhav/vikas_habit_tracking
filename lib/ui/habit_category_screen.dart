// lib/screens/habit_category_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/habit_provider.dart';
import 'habit_card.dart';

class HabitCategoryScreen extends ConsumerWidget {
  const HabitCategoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Habit Categories'),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: habits.length,
        itemBuilder: (context, index) {
          final habit = habits[index];
          return HabitCard(
            habit: habit,
            onEdit: () {
              // Navigate to Habit Detail Screen
              context.go('/habit/${habit.id}');
            },
            onDelete: () {},
          );
        },
      ),
    );
  }
}
