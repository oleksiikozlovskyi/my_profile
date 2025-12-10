import 'package:flutter/material.dart';

class UserStatsWidget extends StatelessWidget {
  final int projects;
  final int followers;
  final int following;

  const UserStatsWidget({
    super.key,
    required this.projects,
    required this.followers,
    required this.following
  });

  Widget _buildStatistic(String label, int value, BuildContext context) {
    return Column(
      children: [
        Text(
          value.toString(),
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatistic("Projects", projects, context),
        _buildStatistic("Followers", followers, context),
        _buildStatistic("Following", following, context),
      ],
    );
  }
}
