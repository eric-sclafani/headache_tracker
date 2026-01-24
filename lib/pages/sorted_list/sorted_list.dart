import 'package:flutter/material.dart';
import 'package:headache_tracker/data/repositories/headache_repository.dart';
import 'package:headache_tracker/features/headache_list/headache_expand_tile.dart';
import 'package:provider/provider.dart';

class SortedList extends StatefulWidget {
  const SortedList({super.key});

  @override
  State<SortedList> createState() => _SortedListState();
}

class _SortedListState extends State<SortedList> {
  @override
  void initState() {
    super.initState();
    context.read<HeadacheRepository>().loadHeadaches();
  }

  @override
  Widget build(BuildContext context) {
    final repo = context.watch<HeadacheRepository>();
    return Container(
      margin: const EdgeInsets.all(20),
      child: ListView.builder(
        itemCount: repo.headacheMap.length,
        itemBuilder: (context, index) {
          var headacheMapEntry = repo.headacheMap[index];
          return HeadacheExpandTile(headacheMap: headacheMapEntry);
        },
      ),
    );
  }
}
