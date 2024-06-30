import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'General Settings',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text('Dark Mode'),
              trailing: Switch(
                value: false,
                onChanged: (value) {
                  // Implement logic to toggle dark mode
                },
              ),
            ),
            Divider(),
            Text(
              'Notifications',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListTile(
              title: Text('Push Notifications'),
              trailing: Switch(
                value: true,
                onChanged: (value) {
                  // Implement logic to toggle push notifications
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
