import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_space/state/auth/providers/auth_state_provider.dart';
import 'package:photo_space/view/constants/app_colors.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
}
