import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'core/presentation/navigation/navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: 'AIzaSyAB8NrncWw0nZweODs8mFd62_oRLN61SI4',
      appId: '1:174977290715:android:e81f02f13680cf4ee397fe',
      messagingSenderId: '174977290715',
      projectId: 'liveblog-40096',
      storageBucket: 'liveblog-40096.appspot.com',
    ));
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);
  final Navigation navigation = Navigation();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(onGenerateRoute: navigation.onGenerateRoute);
  }
}
