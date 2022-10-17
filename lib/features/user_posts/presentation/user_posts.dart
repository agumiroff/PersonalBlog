import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_blog/core/presentation/styles/styles.dart';
import 'package:personal_blog/features/user_posts/presentation/user_posts_bloc.dart';

class UserPosts extends StatelessWidget {
  const UserPosts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SafeArea(
          bottom: false,
          child: TextButton(
              onPressed: () {
                context.pop();
              },
              child: Text('Cancel', style: textStyles.textButtonText)),
        ),
        BlocBuilder<UserPostsBloc, UserPostsStates>(builder: (context, state) {
          if (state is ShowMyPostsState) {
            if (state.listOfData.isEmpty) {
              return const Center(child: Text('У вас нет постов, пока что :)'));
            } else {
              return Expanded(
                child: GridView.count(
                  mainAxisSpacing: 1,
                  crossAxisCount: 3,
                  crossAxisSpacing: 1,
                  children: state.listOfData
                      .map(
                        (post) => GestureDetector(
                          onTap: () {
                            context.go('/my_posts/my_posts_feed');
                          },
                          child: Image.network(post.imagePath, fit: BoxFit.cover),
                        ),
                      )
                      .toList(),
                ),
              );
            }
          }
          if (state is LoadingPosts) {
            return const Center(child: CircularProgressIndicator());
          }
          return const SizedBox.shrink();
        })
      ],
    ));
  }
}
