import 'package:flutter/material.dart';
import 'settings_page.dart';
import 'profile_page.dart';
import 'loading_screen.dart';
import 'no_virus_detected_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '病毒清理器', // 修改标题为中文
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
        Uri.parse('http://192.168.100.17:8080/api/smart-scan?scanType=$scanType'),
      );

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        setState(() {
          scanResult = result['message'];
        });
      } else {
        throw Exception('智能扫描失败'); // 修改异常消息为中文
      }
    } catch (e) {
      if (kDebugMode) {
        print('异常: $e'); // 修改调试信息为中文
      }
      setState(() {
        scanResult = '错误: $e'; // 修改错误消息为中文
      });
    }
  }

  Future<void> performUrlScan(String url) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.100.17:8080/api/url-scan'),
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
        throw Exception('URL扫描失败'); // 修改异常消息为中文
      }
    } catch (e) {
      if (kDebugMode) {
        print('异常: $e'); // 修改调试信息为中文
      }
      setState(() {
        scanResult = '错误: $e'; // 修改错误消息为中文
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('病毒清理器'), // 修改标题为中文
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
              child: Text('智能扫描'), // 修改按钮文本为中文
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UrlScanScreen()),
                );
              },
              child: Text('URL扫描'), // 修改按钮文本为中文
            ),
            SizedBox(height: 20),
            Text(
              scanResult.isNotEmpty ? '扫描结果: $scanResult' : '', // 修改显示文本为中文
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
