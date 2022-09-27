import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  final String value;
  const SuccessPage({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(child: Opacity(opacity: 1, child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: Text(value)),
        const SizedBox(height: 40),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, 'sign_in');
            },
            child: const Text('Войти', style: TextStyle(fontSize: 18))),
      ],
    )));
  }
}
