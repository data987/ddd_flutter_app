import 'package:ddd_flutter_app/injection.dart';
import 'package:ddd_flutter_app/presentation/core/app_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      appId: '1:1091463397636:ios:c7d51186f72b3e77c45051',
      apiKey: 'AIzaSyCSeoaIxcc2Am-uXjnlbyQZqE4OLxrSBbs',
      messagingSenderId: '1091463397636',
      projectId: 'ddd-flutter-app-cd413',
    ),
  );
  configureInjection(Environment.prod);
  runApp(AppWidget());
}
