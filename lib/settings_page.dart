import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  final Function(bool) toggleDarkMode;
  final bool isDarkMode;

  SettingsPage({required this.toggleDarkMode, required this.isDarkMode});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isLatestVersion = false;

  void _checkForUpdates() {
    setState(() {
      _isLatestVersion = true;
    });
  }

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
          children: <Widget>[
            Text(
              'Preferences',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title: Text('Dark Mode'),
              trailing: Switch(
                value: widget.isDarkMode,
                onChanged: (value) {
                  widget.toggleDarkMode(value);
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkForUpdates,
              child: Text('Check for Updates'),
            ),
            if (_isLatestVersion)
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text(
                  'You are already using the latest version.',
                  style: TextStyle(color: Colors.green),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
