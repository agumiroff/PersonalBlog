import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../styles/styles.dart';

class CancelTextButton extends StatelessWidget {
  const CancelTextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        context.pop();
      },
      child: Text('Cancel', style: textStyles.textButtonText),
    );
  }
}
