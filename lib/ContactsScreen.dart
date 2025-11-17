import 'package:flutter/material.dart';

class ContactsScreen extends StatelessWidget {
  const ContactsScreen({super.key});

  final List<Map<String, String>> contacts = const [
    {"name": "Андрій", "phone": "+38095 111 22 33"},
    {"name": "Марина", "phone": "+38096 444 55 66"},
    {"name": "Василь", "phone": "+38097 777 88 99"}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Контакти"),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var contact in contacts) ...[
              Text(contact["name"]!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(contact["phone"]!, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 20),
            ]
          ],
        ),
      ),
    );
  }
}
