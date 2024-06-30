import 'package:flutter/material.dart';
import 'settings_page.dart';
import 'profile_page.dart';
import 'loading_screen.dart';
import 'no_virus_detected_screen.dart';

void main() {
  runApp(CreedAntivirusApp());
}

class CreedAntivirusApp extends StatefulWidget {
  @override
  _CreedAntivirusAppState createState() => _CreedAntivirusAppState();
}

class _CreedAntivirusAppState extends State<CreedAntivirusApp> {
  bool _isDarkMode = false;

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Creed AntiVirus',
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: CreedAntivirusHomePage(
        toggleDarkMode: _toggleDarkMode,
        isDarkMode: _isDarkMode,
      ),
    );
  }
}

class CreedAntivirusHomePage extends StatefulWidget {
  final Function(bool) toggleDarkMode;
  final bool isDarkMode;

  CreedAntivirusHomePage({required this.toggleDarkMode, required this.isDarkMode});

  @override
  _CreedAntivirusHomePageState createState() => _CreedAntivirusHomePageState();
}

class _CreedAntivirusHomePageState extends State<CreedAntivirusHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _startScan(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LoadingScreen(),
      ),
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => NoVirusDetectedScreen(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _pages = <Widget>[
      HomePageContent(
        isDarkMode: widget.isDarkMode,
        startScan: () => _startScan(context),
      ),
      ProfilePage(),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(
              child: Text(
                'Antivirus',
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
        actions: [
          if (!widget.isDarkMode)
            TextButton(
              onPressed: () {
                // Upgrade button action
              },
              child: Text(
                'Upgrade',
                style: TextStyle(color: Colors.white),
              ),
            ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SettingsPage(
                    toggleDarkMode: widget.toggleDarkMode,
                    isDarkMode: widget.isDarkMode,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  final bool isDarkMode;
  final VoidCallback startScan;

  HomePageContent({required this.isDarkMode, required this.startScan});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
            bottom: BorderSide(
              color: Colors.grey,
              width: 1.0,
            ),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 80.0,
              backgroundColor: isDarkMode ? Colors.white : Colors.black,
              child: TextButton(
                onPressed: startScan,
                child: Text(
                  'Scan',
                  style: TextStyle(
                    color: isDarkMode ? Colors.black : Colors.white,
                    fontSize: 18.0,
                  ),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            Text('Scan to detect malware'),
          ],
        ),
      ),
    );
  }
}
