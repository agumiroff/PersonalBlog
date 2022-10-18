import 'package:flutter/material.dart';
import '../../../../core/presentation/styles/styles.dart';

class PostDescription extends StatelessWidget {
  const PostDescription({
    Key? key,
    required this.postDescription,
  }) : super(key: key);
  final TextEditingController postDescription;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: postDescription,
      expands: false,
      maxLines: null,
      style: textStyles.elevatedButtonText,
      decoration: const InputDecoration(
        hintText: 'Enter text here...',
        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.transparent)),
      ),
    );
  }
}
