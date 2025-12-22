import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import '../services/auth_service.dart';
import 'habits_screen.dart';
import 'register_screen.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool loading = false;
  String error = '';

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Вхід')),
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
            // if (error.isNotEmpty)
            //   Text(error, style: const TextStyle(color: Colors.red)),
            if (authProvider.error != null)
              Text(authProvider.error!,
                  style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              // onPressed: loading
              //     ? null
              //     : () async {
              //         setState(() => loading = true);
              //         try {
              //           final user = await AuthService()
              //               .login(emailController.text, passController.text);
              //           if (user != null) {
              //             Navigator.pushReplacement(
              //               context,
              //               MaterialPageRoute(
              //                 builder: (_) => const HabitsScreen(),
              //               ),
              //             );
              //           }
              //         } catch (e) {
              //           setState(() => error = e.toString());
              //         }
              //         setState(() => loading = false);
              //       },
              // child: const Text('Увійти'),
              onPressed: authProvider.isLoading
                  ? null
                  : () async {
                      await context.read<AuthProvider>().login(
                            emailController.text,
                            passController.text,
                          );
                      if (context.read<AuthProvider>().user != null &&
                          context.mounted) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const HabitsScreen(),
                          ),
                        );
                      }
                    },
              child: authProvider.isLoading
                  ? const CircularProgressIndicator()
                  : const Text('Увійти'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const RegisterScreen(),
                  ),
                );
              },
              child: const Text('Створити акаунт'),
            ),
          ],
        ),
      ),
    );
  }
}
