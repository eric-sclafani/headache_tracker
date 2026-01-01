import 'package:flutter/material.dart';
import 'package:headache_tracker/providers/headache_model.dart';
import 'package:provider/provider.dart';
import 'package:headache_tracker/pages/home.dart';
import 'package:headache_tracker/theme/app_theme.dart';
import 'package:wakelock_plus/wakelock_plus.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    WakelockPlus.enable();
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
