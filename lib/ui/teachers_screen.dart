import 'package:flutter/material.dart';

class TeachersScreen extends StatelessWidget {
  const TeachersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Teachers'),
      ),
      body: ListView.builder(
          padding: EdgeInsets.all(16.0),
          itemCount: 10,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text('Teacher ${index + 1}'),
                subtitle: Text('Subject: Math'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    // Delete teacher
                  },
                ),
              ),
            );
          }),
    );
  }
}
