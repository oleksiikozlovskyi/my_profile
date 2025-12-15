import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';

import '../models/habit_model.dart';
import '../services/habit_service.dart';
import 'add_habit_screen.dart';

class HabitsScreen extends StatelessWidget {
  const HabitsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userId = FirebaseAuth.instance.currentUser!.uid;

    return Scaffold(
      appBar: AppBar(title: const Text('Мої звички')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddHabitScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<List<Habit>>(
        stream: HabitService().getHabits(userId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          return MasonryGridView.count(
            crossAxisCount: 2,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, i) {
              final habit = snapshot.data![i];
              final today = DateTime.now().toIso8601String().split('T').first;
              final done = habit.progress[today] ?? false;
              final percent = habit.progress.isEmpty
                  ? 0.0
                  : habit.progress.values.where((e) => e).length /
                      habit.progress.length;

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Text(habit.name, style: const TextStyle(fontSize: 18)),
                      Checkbox(
                        value: done,
                        onChanged: (v) {
                          HabitService().markToday(habit.id, v!);
                        },
                      ),
                      LinearPercentIndicator(
                        percent: percent,
                        center: Text('${(percent * 100).round()}%'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
