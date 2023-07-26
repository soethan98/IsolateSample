import 'dart:isolate';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:multithread_sample/fibonacci_component.dart';

int fibonacci(int n) {
  if (n <= 0) return 0;
  if (n == 1) return 1;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

void fibonacciIsolate(({int number, SendPort sendPort}) data) {
  ReceivePort receivePort = ReceivePort();

  data.sendPort.send(receivePort.sendPort);
  int fib = fibonacci(data.number);
  data.sendPort.send(fib);
  receivePort.listen((message) {
    debugPrint('Roger that main');
  });
}

class IsolateThreadPage extends StatefulWidget {
  const IsolateThreadPage({super.key});

  @override
  State<IsolateThreadPage> createState() => _IsolateThreadPageState();
}

class _IsolateThreadPageState extends State<IsolateThreadPage> {
  int? number;
  int? result;

  @override
  Widget build(BuildContext context) {
    return FibonacciComponent(
      title: 'Isolate',
      number: number,
      result: result,
      onClick: () {
        _calculateFibonacci();
      },
    );
  }

  void _calculateFibonacci() async {
    number = Random().nextInt(50);
    setState(() {});
    final ReceivePort receivePort = ReceivePort();
    await Isolate.spawn(
        fibonacciIsolate, (number: number!, sendPort: receivePort.sendPort));
    receivePort.listen((message) {
      if (message is SendPort) {
        debugPrint('Hi Isolate ! Received your sendPort');
        sendToIsolate(message);
      } else {
        result = message;
        setState(() {});
      }
    });
  }

  sendToIsolate(SendPort sendPort) {
    sendPort.send('Got it ? ');
  }
}
