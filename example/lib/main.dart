import 'dart:math';
import 'package:flutter/material.dart';
import 'package:rolling_counter/rolling_counter.dart';

void main() {
  runApp(const RollingCounterDemoApp());
}

class RollingCounterDemoApp extends StatelessWidget {
  const RollingCounterDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rolling Counter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF5A2E2E)),
        useMaterial3: true,
      ),
      home: const DemoScreen(),
    );
  }
}

class DemoScreen extends StatefulWidget {
  const DemoScreen({super.key});

  @override
  State<DemoScreen> createState() => _DemoScreenState();
}

class _DemoScreenState extends State<DemoScreen> {
  int _balance = 12450;
  double _score = 98.4;

  void _randomize() {
    final rand = Random();
    setState(() {
      _balance = 1000 + rand.nextInt(90000);
      _score = 50.0 + rand.nextDouble() * 50.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F4F0),
      appBar: AppBar(
        title: const Text('Rolling Counter Demo'),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Account Balance',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            RollingCounter(
              value: _balance,
              prefix: '\$',
              textStyle: const TextStyle(
                fontSize: 44,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1F1010),
              ),
            ),
            const SizedBox(height: 36),
            const Text(
              'Performance Metric',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
            const SizedBox(height: 12),
            RollingCounter(
              value: _score,
              suffix: '%',
              fractionDigits: 1,
              textStyle: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w600,
                color: Color(0xFF5A2E2E),
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton.icon(
              onPressed: _randomize,
              icon: const Icon(Icons.refresh),
              label: const Text('Randomize Numbers'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5A2E2E),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
