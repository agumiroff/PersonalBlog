import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_blog/core/data/firebase_keys.dart';
import 'package:personal_blog/core/presentation/pages/success_page.dart';
import 'package:personal_blog/features/add_post/presentation/bloc/add_post_bloc.dart';
import 'package:personal_blog/features/add_post/presentation/pages/add_post_page.dart';
import 'package:personal_blog/features/home/presentation/pages/home_page.dart';
import 'package:personal_blog/features/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:personal_blog/features/sign_in/presentation/pages/sign_in_page.dart';
import 'package:personal_blog/features/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:personal_blog/features/sign_up/presentation/pages/sign_up_page.dart';
import 'package:personal_blog/features/user_posts/presentation/user_posts.dart';
import 'package:personal_blog/features/user_posts/presentation/user_posts_bloc.dart';
import 'package:personal_blog/features/user_search/presentation/pages/user_search.dart';
import 'package:personal_blog/features/user_settings/presentation/bloc/user_settings_bloc.dart';
import 'package:personal_blog/features/user_settings/presentation/pages/bookmarks.dart';
import 'package:personal_blog/features/user_settings/presentation/pages/user_settings.dart';
import 'core/presentation/pages/error_page.dart';
import 'core/presentation/pages/start_page.dart';
import 'features/my_posts_feed/presentation/bloc/my_post_feed_bloc.dart';
import 'features/my_posts_feed/presentation/pages/my_posts_feed.dart';
import 'features/user_settings/presentation/pages/edit_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: apiKey,
      appId: appId,
      messagingSenderId: messagingSenderId,
      projectId: projectId,
      storageBucket: storageBucket,
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (BuildContext context, Widget? child) {
        return const MainPage();
      },
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) => MaterialApp.router(
        routerConfig: _router,
        title: 'LifeBlog',
      );
  final _router = GoRouter(initialLocation: '/', routes: [
    ShellRoute(
        navigatorKey: GlobalKey<NavigatorState>(),
        builder: (context, state, child) => StartPage(child: child),
        routes: [
          GoRoute(
              path: '/',
              builder: (context, state) => BlocProvider(
                    create: (context) => UserSettingsBloc(),
                    child: const UserSettings(),
                  ),
              routes: [
                GoRoute(
                    path: 'my_posts',
                    builder: (context, state) => BlocProvider(
                          create: (context) => UserPostsBloc(),
                          child: const UserPosts(),
                        ),
                    routes: [
                      GoRoute(
                        path: 'my_posts_feed',
                        builder: (BuildContext context, GoRouterState state) => BlocProvider(
                          create: (context) => MyPostFeedBloc(),
                          child: const MyPostFeed(),
                        ),
                      ),
                    ]),
                GoRoute(path: 'edit_profile', builder: (context, state) => const EditUserProfile()),
                GoRoute(
                  path: 'bookmarks',
                  builder: (BuildContext context, GoRouterState state) => BlocProvider(
                    create: (context) => UserSettingsBloc(),
                    child: const BookMarks(),
                  ),
                ),
                GoRoute(
                  path: 'home',
                  pageBuilder: (context, state) => NoTransitionPage(
                    key: state.pageKey,
                    child: const HomePage(),
                  ),
                ),
                GoRoute(
                  path: 'search',
                  pageBuilder: (context, state) => NoTransitionPage(
                    child: const UserSearch(),
                    key: state.pageKey,
                  ),
                ),
                GoRoute(
                  path: 'add_post',
                  pageBuilder: (BuildContext context, GoRouterState state) => NoTransitionPage(
                    key: state.pageKey,
                    child: BlocProvider(
                      create: (context) => AddPostBloc(),
                      child: const AddPostPage(),
                    ),
                  ),
                ),
                GoRoute(
                    path: 'profile_settings',
                    pageBuilder: (BuildContext context, GoRouterState state) => NoTransitionPage(
                          key: state.pageKey,
                          child: BlocProvider(
                            create: (context) => UserSettingsBloc(),
                            child: const UserSettings(),
                          ),
                        )),
              ]),
        ]),
    GoRoute(
      path: '/sign_in',
      builder: (BuildContext context, GoRouterState state) => BlocProvider(
        create: (context) => SignInBloc(),
        child: const SignInPage(),
      ),
    ),
    GoRoute(
      path: '/sign_up',
      builder: (BuildContext context, GoRouterState state) => BlocProvider(
        create: (context) => SignUpBloc(),
        child: const SignUpPage(),
      ),
    ),
    GoRoute(
      path: '/success',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const SuccessPage(),
      ),
    ),
    GoRoute(
      path: '/error',
      pageBuilder: (context, state) => NoTransitionPage(
        key: state.pageKey,
        child: const ErrorPage(),
      ),
    ),
  ]);
}
