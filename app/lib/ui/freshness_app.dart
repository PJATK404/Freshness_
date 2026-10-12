import 'package:flutter/material.dart';

class FreshnessApp extends StatelessWidget {
  const FreshnessApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Freshness',
      theme: ThemeData(colorSchemeSeed: Colors.green),
      home: const Scaffold(body: Center(child: Text('Freshness'))),
    );
  }
}
