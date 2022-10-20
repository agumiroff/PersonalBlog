import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_blog/core/presentation/widgets/app_bar_widget.dart';
import 'package:personal_blog/core/presentation/widgets/cancel_text_button_widget.dart';
import 'package:personal_blog/features/my_posts/presentation/bloc/my_posts_bloc.dart';

class MyPosts extends StatelessWidget {
  const MyPosts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFFF2F2F6),
        appBar: const AppBarWidget(
          actionButton: null,
          leadingButton: CancelTextButton(),
          titleText: 'My posts',
        ),
        body: BlocBuilder<MyPostsBloc, MyPostsStates>(builder: (context, state) {
          if (state is ShowMyPostsState) {
            if (state.listOfData.isEmpty) {
              return const Center(child: Text('У вас нет постов, пока что :)'));
            } else {
              return GridView.count(
                padding: EdgeInsets.all(4.0.w),
                mainAxisSpacing: 1,
                crossAxisCount: 3,
                crossAxisSpacing: 1,
                children: state.listOfData
                    .map(
                      (post) => GestureDetector(
                        onTap: () {
                          context.go('/profile_settings/my_posts/my_posts_feed');
                        },
                        child: Image.network(post.imagePath, fit: BoxFit.cover),
                      ),
                    )
                    .toList(),
              );
            }
          }
          if (state is LoadingPosts) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox.shrink();
        }));
  }
}
