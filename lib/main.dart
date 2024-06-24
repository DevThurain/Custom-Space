import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_space/firebase_options.dart';
import 'package:photo_space/router/app_router.dart';
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

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.customLightTheme,
        darkTheme: AppTheme.customDarkTheme,
        home: Consumer(
          builder: (context, ref, child) {
            ref.listen(loadingProvider, (_, isLoading) {
              if (isLoading) {
                LoadingScreen.instance().show(context: context, text: "Loading ...");
              } else {
                LoadingScreen.instance().hide();
              }
            });
            if (ref.watch(isLoggedInProvider)) {
              return const HomePage();
            }
            return const LoginPage();
          },
        ));
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
