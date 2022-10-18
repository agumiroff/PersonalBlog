import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_blog/core/presentation/widgets/app_bar_widget.dart';
import 'package:personal_blog/features/user_posts/presentation/user_posts_bloc.dart';

class UserPosts extends StatelessWidget {
  const UserPosts({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarWidget(actionButton: null),
        body: BlocBuilder<UserPostsBloc, UserPostsStates>(builder: (context, state) {
          if (state is ShowMyPostsState) {
            if (state.listOfData.isEmpty) {
              return const Center(child: Text('У вас нет постов, пока что :)'));
            } else {
              return GridView.count(
                padding: const EdgeInsets.all(8.0),
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
