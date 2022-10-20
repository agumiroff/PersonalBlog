import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/presentation/styles/styles.dart';
import '../bloc/add_post_bloc.dart';

class NextTextButton extends StatelessWidget {
  final image;
  final TextEditingController postDescription;
  const NextTextButton({Key? key, required this.image, required this.postDescription}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: () {
          BlocProvider.of<AddPostBloc>(context)
              .add(PreviewPostEvent(pickedPhoto: image, postDescription: postDescription.text));
        },
        child: Text('Next', style: textStyles.textButtonText));
  }
}
