import 'package:flutter/material.dart';

import '../models/habit_model.dart';

class HabitDetailScreen extends StatelessWidget {
  final Habit habit;

  const HabitDetailScreen({super.key, required this.habit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(habit.name)),
      body: ListView(
        children: habit.progress.entries.map((item) {
          return ListTile(
            title: Text(item.key),
            trailing: Icon(
              item.value ? Icons.check_circle : Icons.cancel,
              color: item.value ? Colors.green : Colors.red,
            ),
          );
        }).toList(),
      ),
    );
  }
}
