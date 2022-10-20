import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:personal_blog/core/presentation/widgets/app_bar_widget.dart';
import '../../domain/use_cases/select_image.dart';
import '../widgets/next_text_button_widget.dart';
import '../widgets/post_description_widget.dart';

class PickPhotoPage extends StatefulWidget {
  const PickPhotoPage({Key? key}) : super(key: key);

  @override
  State<PickPhotoPage> createState() => _PickPhotoPageState();
}

class _PickPhotoPageState extends State<PickPhotoPage> {
  Uint8List? image;
  Widget imageWidget = Image.asset('assets/empty_photo.jpg');

  @override
  Widget build(BuildContext context) {
    TextEditingController postDescription = TextEditingController();
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F6),
      appBar: AppBarWidget(actionButton: [
        NextTextButton(
          image: image,
          postDescription: postDescription,
        )
      ], leadingButton: null, titleText: 'Add post',),
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(children: [
            SizedBox(
              height: 400.h,
              width: 375.w,
              child: imageWidget,
            ),
            Positioned(
                right: 60.w,
                bottom: 90.h,
                child: IconButton(
                    onPressed: () async {
                      image = await SelectImage().pickImageFromGallery();
                      if (image != null) {
                        imageWidget = Image.memory(image!);
                        setState(() {});
                      }
                    },
                    icon: const Icon(Icons.add_circle, size: 40))),
          ]),
          SizedBox(height: 20.h),
          SizedBox(height: 300.h, child: PostDescription(postDescription: postDescription)),
        ]),
      ),
    );
  }
}
