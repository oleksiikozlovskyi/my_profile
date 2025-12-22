import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_profile/home_task_12/services/habit_service.dart';

import '../models/habit_model.dart';

class HabitProvider extends ChangeNotifier {
  final HabitService _habitService = HabitService();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  bool isLoading = false;

  Future<void> addHabit({
    required String name,
    required String frequency,
    required DateTime startDate,
  }) async {
    isLoading = true;
    notifyListeners();

    final habit = Habit(
      id: '',
      name: name,
      frequency: frequency,
      startDate: startDate,
      progress: {},
      userId: userId,
    );

    await _habitService.addHabit(habit);

    isLoading = false;
    notifyListeners();
  }

  Stream<List<Habit>> get habitsStream {
    return _habitService.getHabits(userId);
  }

  Future<void> markToday(String habitId, bool done) async {
    await _habitService.markToday(habitId, done);
  }
}
