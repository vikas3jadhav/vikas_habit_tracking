// lib/providers/habit_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/habit.dart';
import '../services/hive_service.dart';

final habitProvider = StateNotifierProvider<HabitNotifier, List<Habit>>(
  (ref) => HabitNotifier(),
);

class HabitNotifier extends StateNotifier<List<Habit>> {
  HabitNotifier() : super([]);

  Future<void> loadHabits() async {
    final box = await HiveService.openHabitBox();
    state = box.values.toList();
  }

  Future<void> addHabit(Habit habit) async {
    final box = await HiveService.openHabitBox();
    await box.add(habit); // Add new habit to Hive box
    loadHabits(); // Reload the list of habits from Hive
  }

  Future<void> updateHabit(Habit habit) async {
    final box = await HiveService.openHabitBox();
    await box.put(habit.id, habit); // Update existing habit in Hive
    loadHabits();
  }

  Future<void> deleteHabit(int id) async {
    final box = await HiveService.openHabitBox();
    await box.delete(id); // Delete habit from Hive
    loadHabits();
  }
}
