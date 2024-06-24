import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_space/state/auth/providers/auth_state_provider.dart';
import 'package:photo_space/state/providers/loading_provider.dart';
import 'package:photo_space/view/components/loading/loading_screen.dart';
import 'package:photo_space/view/constants/app_colors.dart';
import 'package:photo_space/view/constants/strings.dart';

@RoutePage()
class LoginPage extends ConsumerWidget {
  static const routeName = 'login_page';
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

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
              onTap: ref.read(authStateProvider.notifier).logOut,
            ),
            SvgIconButton(
              text: 'Sign In With Google',
              svgPath: 'assets/svgs/ic_google.svg',
              iconSize: 25,
              iconSpace: 20,
              onTap: ref.read(authStateProvider.notifier).loginWithGoogle,
            )
          ],
        ),
      ),
    );
  }
}

class SvgIconButton extends StatelessWidget {
  final String svgPath;
  final String text;
  final double iconSize;
  final double iconSpace;
  final VoidCallback onTap;
  const SvgIconButton({
    super.key,
    required this.svgPath,
    required this.text,
    this.iconSize = 30,
    this.iconSpace = 15,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: const MaterialStatePropertyAll(Size(210, 45)),
        elevation: const MaterialStatePropertyAll(0),
        shape: MaterialStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
            side: BorderSide(color: AppColors.seedColor),
          ),
        ),
      ),
      onPressed: onTap,
      child: SizedBox(
        width: 210,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SvgPicture.asset(svgPath, width: iconSize),
            SizedBox(width: iconSpace),
            Text(text),
          ],
        ),
      ),
    );
  }
}
