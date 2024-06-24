import 'package:auto_route/auto_route.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_space/router/app_router.dart';
import 'package:photo_space/state/auth/providers/is_logged_in_provider.dart';
import 'package:photo_space/state/auth/providers/user_id_provider.dart';

class AuthGuard extends AutoRouteGuard {
  final ProviderRef<AppRouter> ref;
  
  AuthGuard({required this.ref});


  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    // the navigation is paused until resolver.next() is called with either
    // true to resume/continue navigation or false to abort navigation
    if(!ref.read(isLoggedInProvider)) {
      // if user is authenticated we continue
      resolver.next(true);
    } else {
        resolver.redirect(
          const HomeRoute(),
      );
    }
  }
}