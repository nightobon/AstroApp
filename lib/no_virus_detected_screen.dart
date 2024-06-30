import 'package:flutter/material.dart';

class NoVirusDetectedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Result'),
      ),
      body: Center(
        child: Text(
          'No virus detected',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
