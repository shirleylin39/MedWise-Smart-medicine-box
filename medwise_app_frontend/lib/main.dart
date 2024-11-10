import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'utils/providers.dart';
import 'welcome_page.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConnectProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedWise',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Welcome(),
    );
  }
}

