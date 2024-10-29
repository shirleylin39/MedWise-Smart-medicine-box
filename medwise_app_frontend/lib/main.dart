import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers.dart';
import 'welcome_page.dart';
import 'api_service.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ConnectProvider()),
      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fetchData();
    });

    return MaterialApp(
      title: 'MedWise',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Welcome(),
    );
  }
}

