import 'package:flutter/material.dart';

class ProfileButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;

  const ProfileButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: const Color(0xFFF2F2F2)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(icon),
              const SizedBox(width: 8),
              Text(
                text,
                style: const TextStyle(
                    color: Color(0xFF121212),
                    fontFamily: 'Noah',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.02),
              ),
              const Spacer(),
              const Icon(Icons.message)
            ],
          ),
        ));
  }
}
