import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // sirf ye wala rakho

void main() {
  runApp(const MyApp()); // MobileAds hata diya
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sum Grid',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  // Adstaree link kholne wala function
  Future<void> _openAdstaree() async {
    final Uri url = Uri.parse('https://mahadplanner192.my.canva.site/');
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sum Grid App')),
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: Text(
                'App Content Here',
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          // Banner ki jaga ye button
          Padding(
            padding: EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: _openAdstaree,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text('Support Us - Adstaree', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ),
        ],
      ),
    );
  }
}