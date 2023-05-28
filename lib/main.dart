import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:tito_login/email/simple/authenticate.dart';
import 'package:tito_login/services/constants/theme.dart';

import 'email/simple/reset_pass.dart';
import 'email/simple/verify_email.dart';
import 'services/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication',
      debugShowCheckedModeBanner: false,
      theme: AppTheme(),
      initialRoute: Home.name,
      routes: {
        Authenticate.name: (_) => const Authenticate(),
        VerifyEmail.name: (_) => const VerifyEmail(),
        ResetPassword.name: (_) => const ResetPassword(),
        Home.name: (_) => const Home(),
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({
    super.key,
  });
  static const name = '/home';

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authentication'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Native Providers - Email/Password , Phone, Anonymous
            TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(Authenticate.name);
                },
                child: const Text('Login with email and Password')),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {},
                child: const Text('Login with email and Password Decorated')),
            const SizedBox(
              height: 10,
            ),
            TextButton(onPressed: () {}, child: const Text('Phone')),
            const SizedBox(
              height: 10,
            ),
            TextButton(onPressed: () {}, child: const Text('Anonymous')),
            const SizedBox(
              height: 10,
            ),
            // Other  - Google,Facebook,Microsoft,Apple,Twitter,Playgames, Github,Yahoo..
            TextButton(onPressed: () {}, child: const Text('Google')),
            const SizedBox(
              height: 10,
            ),
            TextButton(onPressed: () {}, child: const Text('FaceBook')),
            const SizedBox(
              height: 10,
            ),
            TextButton(onPressed: () {}, child: const Text('Microsoft')),
            const SizedBox(
              height: 10,
            ),
            TextButton(onPressed: () {}, child: const Text('Github')),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
