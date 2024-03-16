import 'package:flutter/material.dart';

class CreateNotificationScreen extends StatelessWidget {
  final Function(String) onCreate;

  CreateNotificationScreen({required this.onCreate});

  final TextEditingController _notificationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Notification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _notificationController,
              decoration: InputDecoration(labelText: 'Notification Text'),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                String newNotification = _notificationController.text.trim();
                if (newNotification.isNotEmpty) {
                  onCreate(newNotification);
                  Navigator.pop(
                      context); // Close the create notification screen
                }
              },
              child: Text('Create Notification'),
            ),
          ],
        ),
      ),
    );
  }
}
