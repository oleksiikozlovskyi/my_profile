import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/habit_model.dart';

class HabitService {
  final CollectionReference habits =
      FirebaseFirestore.instance.collection('habits');

  Stream<List<Habit>> getHabits(String userId) {
    return habits.where('userId', isEqualTo: userId).snapshots().map(
        (snapshot) =>
            snapshot.docs.map((item) => Habit.fromFireStore(item)).toList());
  }

  Future<void> addHabit(Habit habit) async {
    await habits.add({
      'name': habit.name,
      'frequency': habit.frequency,
      'startDate': habit.startDate.toIso8601String(),
      'progress': {},
      'userId': habit.userId,
    });
  }

  Future<void> markToday(String habitId, bool done) async {
    final today = DateTime.now().toIso8601String().split('T').first;

    await habits.doc(habitId).update({'progress.$today': done});
  }
}
