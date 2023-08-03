import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quizapp/routes.dart';
import 'package:quizapp/theme.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: appRoutes,
      theme: appTheme,
    );
  }
}
