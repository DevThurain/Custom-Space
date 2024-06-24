import 'package:auto_route/auto_route.dart';
import 'package:photo_space/view/pages/home/home_page.dart';
import 'package:photo_space/view/pages/login/login_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        // routes go here
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: HomeRoute.page),

      ];
}
