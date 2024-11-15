

import 'package:hive_flutter/adapters.dart';

import '../data/habit.dart';

class HiveService {
  static Future<Box<Habit>> openHabitBox() async {
    return await Hive.openBox<Habit>('habitBox');
  }
}
