import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String _name = 'Rey';
  String _birthday = '10/10/1969';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              radius: 50.0,
              child: Icon(Icons.person, size: 50.0),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              controller: TextEditingController(text: _name),
              onChanged: (value) {
                setState(() {
                  _name = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Birthday'),
              controller: TextEditingController(text: _birthday),
              onChanged: (value) {
                setState(() {
                  _birthday = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
