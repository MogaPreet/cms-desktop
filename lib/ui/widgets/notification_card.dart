import 'package:flutter/material.dart';

class NotificationCard extends StatelessWidget {
  final String notification;

  NotificationCard({required this.notification});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListTile(
        contentPadding: EdgeInsets.all(16.0),
        title: Text(
          notification,
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Tap to see details',
          style: TextStyle(color: Colors.grey),
        ),
        trailing: Icon(
          Icons.arrow_forward,
          color: Colors.blue,
        ),
        onTap: () {
          _showNotificationDetails(context);
        },
      ),
    );
  }

  void _showNotificationDetails(BuildContext context) {
    // You can add a dialog or navigate to a detailed notification screen here
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Notification Details'),
          content: Text(notification),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
