import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photo_space/firebase_options.dart';
import 'package:photo_space/state/auth/providers/auth_state_provider.dart';
import 'package:photo_space/state/auth/providers/is_logged_in_provider.dart';
import 'package:photo_space/view/components/loading/alt_loading_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  void _loginFB() async {
    final LoginResult result = await FacebookAuth.instance.login(permissions: ['email']);
    // by default we request the email and the public profile
    // or FacebookAuth.i.login()
    if (result.status == LoginStatus.success) {
      // you are logged
      final AccessToken accessToken = result.accessToken!;
      print("result success:${accessToken.tokenString}");
    } else {
      print(result.status);
      print(result.message);
    }
  }

  void _loginGoogle() async {
    const List<String> scopes = <String>[
      'email',
    ];

    GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: scopes,
    );

    try {
      await googleSignIn.signIn();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer(builder: (context, ref, child) {
              var isUserLoggedIn = ref.watch(isLoggedInProvider);
              return Column(
                children: [
                  Text(isUserLoggedIn ? 'Congrat! You are logged in.' : 'Still Not Logged In.'),
                  const SizedBox(height: 16),
                  isUserLoggedIn
                      ? TextButton(
                          onPressed: () {
                            ref.watch(authStateProvider.notifier).logOut();
                          },
                          child: const Text('Log Out'))
                      : const SizedBox(),
                ],
              );
            }),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AltLoadingScreen.instance().show(context: context, text: "Loading ...");
          // ref.read(authStateProvider.notifier).loginWithGoogle();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
