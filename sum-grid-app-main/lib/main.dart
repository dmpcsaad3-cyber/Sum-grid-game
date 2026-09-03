import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const SumGridApp());

class SumGridApp extends StatelessWidget {
  const SumGridApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sum Grid Game',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});
  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int level = 1;
  int score = 0;
  int questionCount = 0;
  int num1 = 0;
  int num2 = 0;
  String operation = '+';
  int correctAnswer = 0;
  List<int> options = [];
  final Random random = Random();

  // 👇 آپ کا Adsterra SmartLink
  final String smartLink = 'https://www.profitableratecpmnetwork.com/sha5evn4?key=8ea89c1a9a6b1a5092ae29b2c8b2ba57';

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  void generateQuestion() {
    int maxNum = 5 + (level * 3);
    num1 = random.nextInt(maxNum) + 1;
    num2 = random.nextInt(maxNum) + 1;
    List<String> ops = ['+', '-', '×', '÷'];
    operation = ops[random.nextInt(ops.length)];

    if (operation == '-') {
      if (num1 < num2) {
        int temp = num1; num1 = num2; num2 = temp;
      }
      correctAnswer = num1 - num2;
    } else if (operation == '×') {
      num1 = random.nextInt(5 + level) + 1;
      num2 = random.nextInt(5 + level) + 1;
      correctAnswer = num1 * num2;
    } else if (operation == '÷') {
      correctAnswer = random.nextInt(5 + level) + 1;
      num2 = random.nextInt(5 + level) + 1;
      num1 = correctAnswer * num2;
    } else {
      correctAnswer = num1 + num2;
    }

    options = [correctAnswer];
    while (options.length < 4) {
      int wrong = correctAnswer + random.nextInt(10) - 5;
      if (wrong >= 0 &&!options.contains(wrong)) options.add(wrong);
    }
    options.shuffle();
    setState(() {});
  }

  void checkAnswer(int selected) {
    questionCount++;

    if (selected == correctAnswer) {
      score += 10 * level;
      if (score >= level * 100) {
        level++;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('🎉 Level Up! Now Level $level'), backgroundColor: Colors.green),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Correct! +Points'), backgroundColor: Colors.blue, duration: Duration(milliseconds: 500)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Wrong! Correct: $correctAnswer'), backgroundColor: Colors.red),
      );
    }

    // 👇 ہر 2 سوال بعد SmartLink auto کھلے گا
    if (questionCount % 2 == 0) {
      Future.delayed(const Duration(seconds: 1), () {
        _launchSmartLink();
      });
    }

    generateQuestion();
  }

  Future<void> _launchSmartLink() async {
    final Uri url = Uri.parse(smartLink);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Level: $level | Score: $score'), centerTitle: true, backgroundColor: Colors.deepPurple),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Solve:', style: TextStyle(fontSize: 22, color: Colors.grey[700])),
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(color: Colors.amber.shade100, borderRadius: BorderRadius.circular(20)),
              child: Text('$num1 $operation $num2 =?',
                style: const TextStyle(fontSize: 45, fontWeight: FontWeight.bold)),
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                childAspectRatio: 1.8
              ),
              itemBuilder: (context, index) {
                return ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange, // روشن نارنجی بٹن
                    foregroundColor: Colors.white, // سفید نمبر
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 6,
                    textStyle: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () => checkAnswer(options[index]),
                  child: Text('${options[index]}'),
                );
              },
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
              ),
              onPressed: _launchSmartLink,
              icon: const Icon(Icons.favorite, color: Colors.white),
              label: const Text('Support Us', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}