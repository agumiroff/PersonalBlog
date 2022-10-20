import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/domain/entities/post_entity.dart';
import '../../../../core/presentation/widgets/app_bar_widget.dart';
import '../../../../core/presentation/widgets/cancel_text_button_widget.dart';
import '../../../../core/presentation/widgets/post_view.dart';

class UserPostFeedPage extends StatelessWidget {
  final String firstName;
  final String secondName;
  final dynamic listOfPostData;

  const UserPostFeedPage({
    Key? key,
    required this.firstName,
    required this.secondName,
    required this.listOfPostData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F1F7),
      appBar: AppBarWidget(
        actionButton: null,
        leadingButton: const CancelTextButton(),
        titleText: "$firstName's posts",
      ),
      body: Column(
        children: [
          SizedBox(
            height: 670.h,
            child: ListView(
              padding: EdgeInsets.all(4.0.w),
              dragStartBehavior: DragStartBehavior.values.last,
              children: (listOfPostData as List<PostData>)
                  .map((postData) => PostView(
                        postImage: postData.imagePath,
                        postDescription: postData.postDescription,
                        dateTime: postData.dateTime,
                        firstName: firstName,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
