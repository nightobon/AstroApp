import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UrlScanScreen extends StatefulWidget {
  const UrlScanScreen({super.key});

  @override
  _UrlScanScreenState createState() => _UrlScanScreenState();
}

class _UrlScanScreenState extends State<UrlScanScreen> {
  bool isLoading = false;
  String scanResult = '';
  TextEditingController urlController = TextEditingController();

  Future<void> startScan() async {
    setState(() {
      isLoading = true;
      scanResult = '';
    });

    final response = await http.post(
      Uri.parse('http://localhost:8080/api/url-scan'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'url': urlController.text}),
    );

    if (response.statusCode == 200) {
      final result = json.decode(response.body);
      setState(() {
        scanResult = result['result'];
      });
    } else {
      setState(() {
        scanResult = 'Error: ${response.reasonPhrase}';
      });
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('URL Scan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: urlController,
              decoration: InputDecoration(labelText: 'Enter URL to scan'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: startScan,
              child: Text('Start Scan'),
            ),
            SizedBox(height: 20),
            if (isLoading) CircularProgressIndicator(),
            if (scanResult.isNotEmpty) Text('Scan Result: $scanResult'),
          ],
        ),
      ),
    );
  }
}
