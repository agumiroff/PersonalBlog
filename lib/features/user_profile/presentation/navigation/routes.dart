import 'package:flutter/material.dart';
import 'package:personal_blog/features/user_profile/presentation/pages/bookmarks.dart';
import 'package:personal_blog/features/user_profile/presentation/pages/my_posts.dart';
import 'package:personal_blog/features/user_profile/presentation/pages/post_feed.dart';
import '../../../../core/presentation/pages/error_page.dart';
import '../pages/edit_profile.dart';
import '../pages/user_profile_page.dart';

class UserProfileNavigation {
  Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const UserProfilePage());
      case 'bookmarks':
        return MaterialPageRoute(builder: (_) => const BookMarks());
      case 'posts':
        return MaterialPageRoute(builder: (_) => const MyPosts());
      case 'edit_profile':
        return MaterialPageRoute(builder: (_) => const EditUserProfile());
      case 'feed':
        return MaterialPageRoute(builder: (_) => const PostFeed());
      default:
        return MaterialPageRoute(
            builder: (_) => ErrorScreen(
                  value: 'Error',
                  onPressed: () {},
                ));
    }
  }
}
