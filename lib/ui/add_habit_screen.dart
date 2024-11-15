// lib/screens/add_habit_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../data/habit.dart';
import '../providers/habit_provider.dart';
import '../services/platform_services.dart';

class AddHabitScreen extends ConsumerStatefulWidget {
  const AddHabitScreen({super.key});

  @override
  _AddHabitScreenState createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends ConsumerState<AddHabitScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _habitNameController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();

  @override
  void dispose() {
    _habitNameController.dispose();
    _categoryController.dispose();
    _goalController.dispose();
    super.dispose();
  }

  void _addHabit(BuildContext context) {
    final habitName = _habitNameController.text;
    final category = _categoryController.text;
    final goal = int.tryParse(_goalController.text);

    if (habitName.isEmpty || category.isEmpty || goal == null || goal <= 0) {
      // Show a message if validation fails
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid values')),
      );
      return;
    }

    final newHabit = Habit(
      id: DateTime.now().millisecondsSinceEpoch, // Unique ID based on timestamp
      name: habitName,
      category: category,
      goal: goal,
    );

    if (habitName.isNotEmpty) {
      // Call the platform channel to show toast
      PlatformChannel.showToast('Habit "$habitName" added successfully!');
      
      // Logic to save habit and navigate back, etc.
      Navigator.pop(context);
    

    // Use Riverpod to add the new habit
    ref.read(habitProvider.notifier).addHabit(newHabit);

    // Navigate back to the dashboard after adding the habit
    context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Habit'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _habitNameController,
                decoration: const InputDecoration(labelText: 'Habit Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a habit name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a category';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _goalController,
                decoration: const InputDecoration(labelText: 'Goal Frequency'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a goal frequency';
                  }
                  if (int.tryParse(value) == null || int.tryParse(value)! <= 0) {
                    return 'Please enter a valid positive number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => _addHabit(context),
                child: const Text('Add Habit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
