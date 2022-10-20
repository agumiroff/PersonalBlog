import 'package:flutter/material.dart';
import 'package:personal_blog/core/presentation/widgets/app_bar_widget.dart';
import 'package:personal_blog/core/presentation/widgets/cancel_text_button_widget.dart';

class EditMyProfilePage extends StatelessWidget {
  const EditMyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(leadingButton: const CancelTextButton(), titleText: 'Edit profile'),
      body: Column(
        children: [],
      ),
    );
  }
}
