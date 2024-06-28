import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_space/router/app_router.dart';
import 'package:photo_space/state/auth/providers/auth_state_provider.dart';
import 'package:photo_space/state/auth/providers/is_logged_in_provider.dart';
import 'package:photo_space/view/constants/app_colors.dart';
import 'package:photo_space/view/pages/based/based_page.dart';

@RoutePage()
class HomePage extends BasedPage {
  HomePage({super.key});

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: AppColors.whiteColor),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        actions: [
          Consumer(builder: (context, ref, child) {
            return IconButton(
              onPressed: ref.read(authStateProvider.notifier).logOut,
              icon: const Icon(Icons.logout),
            );
          })
        ],
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
