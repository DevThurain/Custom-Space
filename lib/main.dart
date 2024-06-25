import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_space/firebase_options.dart';
import 'package:photo_space/router/app_router.dart';
import 'package:photo_space/router/guards/auth_guard.dart';
import 'package:photo_space/state/auth/providers/is_logged_in_provider.dart';
import 'package:photo_space/state/providers/loading_provider.dart';
import 'package:photo_space/view/components/loading/loading_screen.dart';
import 'package:photo_space/view/constants/app_theme.dart';
import 'package:photo_space/view/pages/home/home_page.dart';
import 'package:photo_space/view/pages/login/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

var appRouterProvider = Provider<AppRouter>((ref) => AppRouter(authGuard: AuthGuard(ref: ref)));

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: AppTheme.customLightTheme,
      darkTheme: AppTheme.customDarkTheme,
      routerConfig: ref.read(appRouterProvider).config(),
    );
  }
  // home: Consumer(builder: (context, ref, child) {
  //   ref.listen(loadingProvider, (_, isLoading) {
  //     if (isLoading) {
  //       LoadingScreen.instance().show(context: context, text: "Loading ...");
  //     } else {
  //       LoadingScreen.instance().hide();
  //     }
  //   });
  //   return const LoginPage();
  // }),
}
