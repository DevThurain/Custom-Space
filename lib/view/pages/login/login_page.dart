import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_space/router/app_router.dart';
import 'package:photo_space/state/auth/providers/auth_state_provider.dart';
import 'package:photo_space/state/auth/providers/is_logged_in_provider.dart';
import 'package:photo_space/view/constants/app_colors.dart';
import 'package:photo_space/view/constants/strings.dart';
import 'package:photo_space/view/pages/based/based_page.dart';
import 'package:photo_space/view/pages/login/widgets/svg_icon_button.dart';

@RoutePage()
class LoginPage extends BasedPage {
  static const routeName = 'login_page';
  LoginPage({super.key});

  @override
  Widget buildContent(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          Strings.appName,
          style: TextStyle(color: AppColors.whiteColor),
        ),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgIconButton(
              text: 'Sign In With Facebook',
              svgPath: 'assets/svgs/ic_facebook.svg',
              onTap: () {
                showLoadingDailog(context);
              },
            ),
            SvgIconButton(
              text: 'Sign In With Google',
              svgPath: 'assets/svgs/ic_google.svg',
              iconSize: 25,
              iconSpace: 20,
              onTap: ref.read(authStateProvider.notifier).loginWithGoogle,
            ),
            AspectRatio(aspectRatio: aspectRatio)
          ],
        ),
      ),
    );
  }

  @override
  void buildListeners(BuildContext context, WidgetRef ref) {
    super.buildListeners(context, ref);
    ref.listen(isLoggedInProvider, (_, isLoggedIn) async {
      if (isLoggedIn) {
        AutoRouter.of(context).replace(const HomeRoute());
      }
    });
  }
}
