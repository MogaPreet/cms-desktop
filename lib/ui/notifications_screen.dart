import 'package:flutter/material.dart';
import 'create_notification_screen.dart';
import 'widgets/notification_card.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  _NotificationsScreenState createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<String> notifications = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.notifications),
        title: const Text('Add Notification / Announcement'),
      ),
      body: notifications.isEmpty
          ? const Center(
              child: Text('No notifications yet.'),
            )
          : ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (BuildContext context, int index) {
                return NotificationCard(notification: notifications[index]);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  CreateNotificationScreen(onCreate: _addNotification),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addNotification(String notification) {
    setState(() {
      notifications.add(notification);
    });
  }
}
