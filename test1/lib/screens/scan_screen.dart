import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  bool isLoading = false;
  String scanResult = '';
  String scanType = 'Full';

  Future<void> startScan() async {
    setState(() {
      isLoading = true;
      scanResult = '';
    });

    try {
      final response = await http.get(Uri.parse('http://localhost:8080/api/smart-scan?scanType=$scanType'));

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
    } catch (e) {
      setState(() {
        scanResult = 'Error: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Smart Scan'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Full Scan'),
                    leading: Radio<String>(
                      value: 'Full',
                      groupValue: scanType,
                      onChanged: (String? value) {
                        setState(() {
                          scanType = value!;
                        });
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Quick Scan'),
                    leading: Radio<String>(
                      value: 'Quick',
                      groupValue: scanType,
                      onChanged: (String? value) {
                        setState(() {
                          scanType = value!;
                        });
                      },
                    ),
                  ),
                ),
              ],
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
