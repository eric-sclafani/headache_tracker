import 'package:flutter/material.dart';
import 'package:headache_tracker/data/repositories/headache_repository.dart';
import 'package:provider/provider.dart';

class StatsView extends StatefulWidget {
  const StatsView({super.key});

  @override
  State<StatsView> createState() => _StatsViewState();
}

class _StatsViewState extends State<StatsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<HeadacheRepository>();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(children: [RichText(text: text)]),
    );
  }
}
