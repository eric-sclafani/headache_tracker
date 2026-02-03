import 'package:flutter/material.dart';
import 'package:headache_tracker/data/repositories/headache_repository.dart';
import 'package:provider/provider.dart';

class StatsView extends StatelessWidget {
  const StatsView({super.key});

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<HeadacheRepository>();
    var labelValuePairs = _getStatValueLabelPairs(repo);
    return Column(
      children: [
        Text(
          '(Recording started November 2025)',
          style: TextStyle(
            fontStyle: FontStyle.italic,
            color: Colors.red.shade900,
          ),
        ),
        Divider(),
        Expanded(
          child: ListView.separated(
            itemCount: labelValuePairs.length,
            separatorBuilder: (_, _) => Divider(),
            itemBuilder: (BuildContext context, int index) {
              var pair = labelValuePairs[index];
              return ListTile(
                title: Padding(
                  padding: const EdgeInsets.only(right: 80),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: 15,
                    children: [
                      Text(pair.$1),
                      Text(
                        pair.$2.toString(),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  static List<(String, int)> _getStatValueLabelPairs(HeadacheRepository repo) {
    var pairs = [
      ('Total Headaches:', repo.totalHeadaches),
      ('Avg Monthly Headaches:', repo.getAvgHeadachesPerMonth()),
      ('Total Advil taken:', repo.totalAdvils),
      ('Avg Monthly Advil:', repo.getAvgAdvilPerMonth()),
      ('Avg Advil Per Headache:', repo.getAvgAdvilPerHeadache()),
    ];

    return pairs;
  }
}
