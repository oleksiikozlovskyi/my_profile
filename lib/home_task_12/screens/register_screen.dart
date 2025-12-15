import 'package:flutter/material.dart';
import 'package:my_profile/home_task_12/screens/habits_screen.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  String error = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Реєстрація')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: passController,
              obscureText: true,
              decoration: const InputDecoration(labelText: 'Пароль'),
            ),
            const SizedBox(height: 20),
            if (error.isNotEmpty)
              Text(error, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: () async {
                try {
                  final user = await AuthService()
                      .register(emailController.text, passController.text);
                  if (user != null) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const HabitsScreen(),
                      ),
                    );
                  }
                } catch (e) {
                  setState(() => error = e.toString());
                }
              },
              child: const Text('Зареєструватися'),
            ),
          ],
        ),
      ),
    );
  }
}
