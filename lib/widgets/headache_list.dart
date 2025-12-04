import 'package:flutter/material.dart';
import 'package:headache_tracker/providers/headache_model.dart';
import 'package:provider/provider.dart';

class HeadacheList extends StatelessWidget {
  const HeadacheList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HeadacheModel>(
      builder: (context, headacheModel, _) => Expanded(
        child: ListView.separated(
          itemCount: headacheModel.allHeadaches.length,
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(),
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(headacheModel.allHeadaches[index].toString()),
            );
          },
        ),
      ),
    );
  }
}
