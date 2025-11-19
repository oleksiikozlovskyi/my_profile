import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  final String name;
  final String description;
  final String avatarPath;

  const ProfileHeader({
    super.key,
    required this.name,
    required this.description,
    required this.avatarPath
  });

  @override
  Widget build(BuildContext context) {
    final double avatarSize = MediaQuery.of(context).size.width * 0.2;

    return Row(
      children: [
        CircleAvatar(
          radius: avatarSize / 2,
          backgroundImage: AssetImage(avatarPath),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                description,
                style: Theme.of(context).textTheme.bodyMedium,
              )
            ],
          ),
        ),
      ],
    );
  }
}
