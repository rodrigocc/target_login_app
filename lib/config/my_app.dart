import 'package:flutter/material.dart';
import 'package:target_sistemas/features/login/presentation/pages/login_page.dart';

class TargetLoginApp extends StatelessWidget {
  const TargetLoginApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
