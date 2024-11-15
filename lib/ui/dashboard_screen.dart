import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vikas_habit_tracking/repo/quote_repo.dart';
import '../providers/habit_provider.dart';
import 'habit_card.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final habits = ref.watch(habitProvider);  // Get habit data from Riverpod provider
    final quoteService = QuoteRepo();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          // Button to navigate to Add Habit screen
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              context.go('/add'); // Navigate to Add Habit Screen
            },
          ),
        ],
      ),
      body: habits.isEmpty
          ? FutureBuilder<List<String>>(
              future: quoteService.fetchQuotes(),  // Fetch a list of quotes
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                if (snapshot.hasData) {
                  final quotes = snapshot.data!;

                  return ListView.builder(
                    itemCount: quotes.length,
                    itemBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        elevation: 4.0,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            quotes[index],
                            style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                          ),
                        ),
                      );
                    },
                  );
                }

                return Center(child: Text('No quotes available.'));
              },
            )
          : ListView.builder(
              itemCount: habits.length,
              itemBuilder: (context, index) {
                final habit = habits[index];
                return HabitCard(
                  habit: habit,
                  onEdit: () {
                    context.go('/habit/${habit.id}');  // Navigate to Habit Detail Screen
                  },
                  onDelete: () async {
                    await ref.read(habitProvider.notifier).deleteHabit(habit.id);  // Delete habit
                  },
                );
              },
            ),
    );
  }
}
