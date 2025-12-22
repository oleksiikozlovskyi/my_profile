import 'package:flutter/material.dart';
import 'package:my_profile/home_task_12/providers/habit_provider.dart';
import 'package:provider/provider.dart';

class AddHabitScreen extends StatefulWidget {
  const AddHabitScreen({super.key});

  @override
  State<AddHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<AddHabitScreen> {
  final nameController = TextEditingController();
  String frequency = 'Щодня';
  DateTime startDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final habitProvider = context.watch<HabitProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Нова звичка')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Назва звички'),
            ),
            DropdownButton(
              value: frequency,
              items: const [
                DropdownMenuItem(value: 'Щодня', child: Text('Щодня')),
                DropdownMenuItem(
                    value: 'Раз на тиждень', child: Text('Раз на тиждень')),
              ],
              onChanged: (v) => setState(() => frequency = v!),
            ),
            ElevatedButton(
              // onPressed: () async {
              //   await HabitService().addHabit(
              //     Habit(
              //       id: '',
              //       name: nameController.text,
              //       frequency: frequency,
              //       startDate: startDate,
              //       progress: {},
              //       userId: FirebaseAuth.instance.currentUser!.uid,
              //     ),
              //   );
              //   Navigator.pop(context);
              // },
              onPressed: habitProvider.isLoading
                  ? null
                  : () async {
                      await context.read<HabitProvider>().addHabit(
                          name: nameController.text,
                          frequency: frequency,
                          startDate: startDate);
                      Navigator.pop(context);
                    },
              child: const Text('Додати'),
            ),
          ],
        ),
      ),
    );
  }
}
