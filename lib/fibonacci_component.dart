import 'package:flutter/material.dart';

class FibonacciComponent extends StatelessWidget {
  final String title;
  final int? number;
  final int? result;
  final VoidCallback onClick;
  const FibonacciComponent(
      {super.key,
      required this.number,
      required this.title,
      required this.onClick,
      this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          children: [
            if (result != null) Text('Number - $number'),
            const SizedBox(
              height: 16,
            ),
            if (result != null) Text('Fibonacci of $number- $result'),
            const SizedBox(
              height: 16,
            ),
            const CircularProgressIndicator(),
            const SizedBox(
              height: 24,
            ),
            ElevatedButton(
                onPressed: onClick, child: const Text('Generate Fibonacci'))
          ],
        ),
      ),
    );
  }
}
