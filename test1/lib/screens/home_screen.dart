import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
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

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Future<void> performSmartScan(String scanType) async {
    try {
      final response = await http.get(Uri.parse('http://localhost:8080/api/smart-scan?scanType=$scanType'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        if (kDebugMode) {
          print('Smart Scan Result: $jsonResponse');
        }
        // Show result in UI or process further
      } else {
        if (kDebugMode) {
          print('Request failed with status: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
        throw Exception('Failed to perform smart scan');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception: $e');
      }
      // Handle exceptions: show error message in UI or alert dialog
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
        final jsonResponse = json.decode(response.body);
        if (kDebugMode) {
          print('URL Scan Result: $jsonResponse');
        }
        // Show result in UI or process further
      } else {
        if (kDebugMode) {
          print('Request failed with status: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
        throw Exception('Failed to perform URL scan');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Exception: $e');
      }
      // Handle exceptions: show error message in UI or alert dialog
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: const [
            Text('Virus Cleaner'),
            Divider(),
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Smart Scan'),
              onPressed: () async {
                await performSmartScan('full');
              },
            ),
            ElevatedButton(
              child: const Text('URL Scan'),
              onPressed: () async {
                await performUrlScan('https://example.com');
              },
            ),
          ],
        ),
      ),
    );
  }
}
