import 'package:flutter/material.dart';
import 'package:headache_tracker/providers/headache_model.dart';
import 'package:provider/provider.dart';
import 'package:headache_tracker/pages/home.dart';
import 'package:headache_tracker/theme/app_theme.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HeadacheModel(),
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
