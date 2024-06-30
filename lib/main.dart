import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_space/firebase_options.dart';
import 'package:photo_space/router/app_router.dart';
import 'package:photo_space/router/guards/auth_guard.dart';
import 'package:photo_space/view/constants/app_theme.dart';

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
}
