import 'package:flutter/material.dart';
import 'package:headache_tracker/features/form_modal/headache_modal.dart';
import 'package:headache_tracker/features/headache_list_display/headache_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _appBar(),
      floatingActionButton: _floatingActionBtn(),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [HeadacheList()],
        ),
      ),
    );
  }

  IconButton _floatingActionBtn() {
    return IconButton.filled(
      onPressed: () {
        showAddEditDialog(context: context, mode: 'add');
      },
      icon: const Icon(Icons.add_sharp, size: 60),
    );
  }

  AppBar _appBar() {
    return AppBar(
      centerTitle: true,
      title: const Text(
        'My Headaches',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      forceMaterialTransparency: true,
    );
  }
}
