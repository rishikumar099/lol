import 'package:flutter/material.dart';
import 'package:ss_media/pages/home.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.pink,
      ),
      title: 'SS MEDIA',
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}
