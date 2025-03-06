import 'package:flutter/material.dart';

// Pages
import 'pages/home/home.page.dart';
import 'pages/add/add.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light(useMaterial3: true),
      routes: {
        "/": (context) => HomePage(title: 'Bucket List'),
        "/add": (context) => AddPage(),
      },
      // home: const HomePage(title: 'Bucket List'),
      // * Nota) Cuando se manejan rutas, no se indica el "home" sino el "initialRoute"
      initialRoute: '/',
    );
  }
}
