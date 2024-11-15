import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:vikas_habit_tracking/ui/dashboard_screen.dart';

import '../ui/add_habit_screen.dart';
import '../ui/habit_category_screen.dart';
import '../ui/habit_detail_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref){
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
        // Route for Dashboard Screen
        GoRoute(
          path: '/',
          builder: (context, state) {
            return const DashboardScreen();
          },
          routes: [
            // Route for Habit Categories Screen
            GoRoute(
              path: 'categories',
              builder: (context, state) {
                return const HabitCategoryScreen();
              },
            ),
            // Route for Habit Detail Screen
            GoRoute(
              path: 'habit/:id',
              builder: (context, state) {
                final habitId = state.pathParameters['id']!;
                return HabitDetailScreen(habitId: int.parse(habitId));
              },
            ),
            // Route for Add Habit Screen
            GoRoute(
              path: '/add',
              builder: (context, state) {
                return const AddHabitScreen();
              },
            ),
          ],
        ),
      ],
    );
});