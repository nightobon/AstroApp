import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_1/screens/scan_screen.dart';
import 'package:test_1/screens/settings_screen.dart';
import 'package:test_1/screens/url_scan_screen.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Virus Cleaner',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String scanResult = '';

  Future<void> performSmartScan(String scanType) async {
    try {
      final response = await http.get(
        Uri.parse('http://localhost:8080/api/smart-scan?scanType=$scanType'),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        setState(() {
          scanResult = result['message'];
        });
      } else {
        throw Exception('Failed to perform smart scan');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception: $e');
      }
      setState(() {
        scanResult = 'Error: $e';
      });
    }
  }

  Future<void> performUrlScan(String url) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/api/url-scan'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'url': url}),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        setState(() {
          scanResult = result['message'];
        });
      } else {
        throw Exception('Failed to perform URL scan');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception: $e');
      }
      setState(() {
        scanResult = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Virus Cleaner'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ScanScreen()),
                );
              },
              child: Text('Smart Scan'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UrlScanScreen()),
                );
              },
              child: Text('URL Scan'),
            ),
            SizedBox(height: 20),
            Text(
              scanResult.isNotEmpty ? 'Scan Result: $scanResult' : '',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
