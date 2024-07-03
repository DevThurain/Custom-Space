import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_space/router/app_router.dart';
import 'package:photo_space/state/auth/providers/auth_state_provider.dart';
import 'package:photo_space/state/auth/providers/is_logged_in_provider.dart';
import 'package:photo_space/view/constants/app_colors.dart';
import 'package:photo_space/view/constants/strings.dart';
import 'package:photo_space/view/pages/based/based_page.dart';

@RoutePage()
class HomePage extends BasedPage {
  HomePage({super.key});

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            Strings.appName,
            style: TextStyle(color: AppColors.whiteColor),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          actions: [
            IconButton(
              onPressed: ref.read(authStateProvider.notifier).logOut,
              icon: const Icon(
                Icons.camera,
                color: AppColors.whiteColor,
              ),
            ),
            IconButton(
              onPressed: ref.read(authStateProvider.notifier).logOut,
              icon: const Icon(
                Icons.logout_outlined,
                color: AppColors.whiteColor,
              ),
            ),
          ],
          bottom: TabBar(
              indicatorColor: Theme.of(context).colorScheme.surface,
              indicatorSize: TabBarIndicatorSize.label,
              dividerColor: Theme.of(context).colorScheme.surface,
              tabs: const [
                Tab(
                  icon: Icon(
                    Icons.home_max_outlined,
                    color: AppColors.whiteColor,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.search_outlined,
                    color: AppColors.whiteColor,
                  ),
                ),
                Tab(
                  icon: Icon(
                    Icons.person_outline,
                    color: AppColors.whiteColor,
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  @override
  void buildListeners(BuildContext context, WidgetRef ref) {
    super.buildListeners(context, ref);
    ref.listen(isLoggedInProvider, (_, isLoggedIn) {
      if (!isLoggedIn) {
        AutoRouter.of(context).replace(LoginRoute());
      }
    });
  }
}
