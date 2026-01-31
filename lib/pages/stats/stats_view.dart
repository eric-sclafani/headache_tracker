import 'package:flutter/material.dart';
import 'package:headache_tracker/data/repositories/headache_repository.dart';
import 'package:provider/provider.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<HeadacheRepository>();
    var labelValuePairs = _getStatValueLabelPairs(repo);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.builder(
        itemCount: labelValuePairs.length,
        itemBuilder: (BuildContext context, int index) {
          var pair = labelValuePairs[index];
          return ListTile(title: Row(children: [Text(pair.$1)]));
        },
      ),
    );
  }

  static List<(String, double)> _getStatValueLabelPairs(
    HeadacheRepository repo,
  ) {
    var pairs = [
      ('Avg Headaches Per Month', repo.getAvgHeadachesPerMonth()),
      ('Avg Advil Per Month', repo.getAvgAdvilPerMonth()),
    ];

    return pairs;
  }
}
