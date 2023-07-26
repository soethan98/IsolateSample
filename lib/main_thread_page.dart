import 'dart:isolate';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multithread_sample/fibonacci_component.dart';

class MainThreadPage extends StatefulWidget {
  const MainThreadPage({super.key});

  @override
  State<MainThreadPage> createState() => _MainThreadPageState();
}

class _MainThreadPageState extends State<MainThreadPage> {
  int? number;
  int? result;

  void _calculateFibonacci() {
    number = Random().nextInt(50);
    result = fibonacci(number!);
    setState(() {});
  }

  int fibonacci(int n) {
    if (n <= 0) return 0;
    if (n == 1) return 1;
    return fibonacci(n - 1) + fibonacci(n - 2);
  }

  @override
  Widget build(BuildContext context) {
    return FibonacciComponent(
      title: 'Main Thread',
      number: number,
      result: result,
      onClick: () {
        _calculateFibonacci();
      },
    );
  }
}
