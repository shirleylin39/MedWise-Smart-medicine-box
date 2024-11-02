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
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  // This widget is the root of your application.

  final dataService = DataService();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      dataService.fetchData();
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

