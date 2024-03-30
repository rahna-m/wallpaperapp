import 'package:flutter/material.dart';
import 'package:wallpapperapp/wallpaper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomeTheme',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       brightness: Brightness.dark,
        useMaterial3: true,
      ),
      home: const Wallpaper(),
    );
  }
}

