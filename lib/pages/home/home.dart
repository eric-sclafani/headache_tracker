import 'package:flutter/material.dart';
import 'package:headache_tracker/features/form_modal/headache_modal.dart';
import 'package:headache_tracker/pages/sorted_list/sorted_list.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _appBar(),
      floatingActionButton: _floatingActionBtn(context),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [SortedList()],
        ),
      ),
    );
  }

  IconButton _floatingActionBtn(BuildContext context) {
    return IconButton.filled(
      onPressed: () {
        showAddEditDialog(context: context);
      },
      icon: const Icon(Icons.note_add, size: 50),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      forceMaterialTransparency: true,
      leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
    );
  }
}
