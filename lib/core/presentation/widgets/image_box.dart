import 'package:flutter/material.dart';
import 'package:personal_blog/core/presentation/widgets/avatar_widget.dart';

class ImageBox extends StatelessWidget {
  final image;

  const ImageBox({
    Key? key,
    required this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      width: 300,
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: image,
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }
}
