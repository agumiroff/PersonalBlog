import 'package:get_it/get_it.dart';
import 'package:personal_blog/core/presentation/navigation/global_navigation.dart';
import 'package:personal_blog/features/user_profile/presentation/bloc/user_profile_bloc.dart';
import '../presentation/navigation/navigation.dart';

GetIt _locator = GetIt.instance;
ServiceLocator locator = ServiceLocator();

void setupLocator() {
  _locator.registerLazySingleton(() => NavigationService());
  _locator.registerLazySingleton(() => UserProfileBloc(GlobalNavigationService()));
  _locator.registerLazySingleton(() => GlobalNavigationService());
}

class ServiceLocator {
  NavigationService get navigationService => _locator.get<NavigationService>();
  UserProfileBloc get userProfileBloc => _locator.get<UserProfileBloc>();
  GlobalNavigationService get globalNavigationService => _locator.get<GlobalNavigationService>();
}
