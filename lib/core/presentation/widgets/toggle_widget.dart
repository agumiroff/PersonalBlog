import 'package:flutter/material.dart';

class ToggleWidget extends StatelessWidget {
  const ToggleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 71,
      height: 36,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          color: const Color(0xFF9F9F9F),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
