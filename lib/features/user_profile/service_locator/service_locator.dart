import 'package:get_it/get_it.dart';
import 'package:personal_blog/core/presentation/navigation/global_navigation.dart';
import 'package:personal_blog/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import '../presentation/navigation/navigation.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => ServiceLocator());
}

class ServiceLocator {
  NavigationService navigationService = NavigationService();
  UserProfileBloc userProfileBloc = UserProfileBloc();
  GlobalNavigationService globalNavigationService = GlobalNavigationService();
}
