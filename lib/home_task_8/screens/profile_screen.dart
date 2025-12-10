import 'package:flutter/material.dart';

import '../widgets/profile_header.dart';
import '../widgets/user_stats.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double spacing = MediaQuery.of(context).size.height * 0.02;

    return Scaffold(
      appBar: AppBar(
        title: const Text("User profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProfileHeader(
              name: "Sofiia Bykovska",
              description: "Flutter Developer",
              avatarPath: "assets/image/alice_madness.jpg",
            ),
            SizedBox(
              height: spacing,
            ),
            const Divider(),
            SizedBox(
              height: spacing,
            ),
            UserStatsWidget(
              projects: 32,
              followers: 1280,
              following: 320,
            ),
          ],
        ),
      ),
    );
  }
}
