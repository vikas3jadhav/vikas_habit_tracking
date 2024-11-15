import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/habit.dart';
import 'providers/go_router_provider.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(HabitAdapter());
  await Hive.openBox<Habit>('habits');

  runApp(const ProviderScope(child: HabitApp()));
}

class HabitApp extends ConsumerStatefulWidget{
  const HabitApp({super.key});
  
  @override
  ConsumerState<HabitApp> createState() => _HabitApp();
}

class _HabitApp extends ConsumerState<HabitApp>{
  @override
  Widget build(Object context) {
    final goRouterConfig = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: goRouterConfig,
    );
  }

}