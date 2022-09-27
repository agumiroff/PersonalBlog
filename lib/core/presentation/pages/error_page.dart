import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  final VoidCallback onPressed;
  final String value;
  const ErrorScreen({Key? key, required this.value, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromRGBO(11, 20, 21, 0.3),
      child: Center(
          child: SizedBox(
        width: 300,
        height: 200,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.transparent),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                value,
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(onPressed: onPressed, child: const Text('Ввести заново', style: TextStyle(fontSize: 18)))
            ],
          ),
        ),
      )),
    );
  }
}
