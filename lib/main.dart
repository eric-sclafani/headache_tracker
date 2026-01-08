import 'package:flutter/material.dart';
import 'package:headache_tracker/data/dao/headache_dao.dart';
import 'package:headache_tracker/data/dao/timestamp_dao.dart';
import 'package:headache_tracker/data/repositories/headache_repository.dart';
import 'package:headache_tracker/data/repositories/timestamp_repository.dart';
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
    return MultiProvider(
      providers: [
        Provider<HeadacheDao>(create: (_) => HeadacheDao()),
        Provider<TimestampDao>(create: (_) => TimestampDao()),
        ChangeNotifierProvider<HeadacheRepository>(
          create: (context) => HeadacheRepository(
            context.read<HeadacheDao>(),
            context.read<TimestampDao>(),
          ),
        ),
        ChangeNotifierProvider<TimestampRepository>(
          create: (context) =>
              TimestampRepository(context.read<TimestampDao>()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Home(),
        theme: AppTheme.lightTheme,
      ),
    );
  }
}
