import 'package:flutter/material.dart';
import 'package:headache_tracker/features/form_modal/headache_modal.dart';
import 'package:headache_tracker/pages/stats/stats_view.dart';
import 'package:headache_tracker/pages/sorted_list/sorted_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _appBar(),
      floatingActionButton: _floatingActionBtn(context),
      body: [SortedList(), StatsView(), Text('')][currentPageIndex],
      bottomNavigationBar: _bottomNavBar(),
    );
  }

  NavigationBar _bottomNavBar() {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      selectedIndex: currentPageIndex,
      labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
      indicatorColor: Colors.blue.shade300,
      destinations: [
        NavigationDestination(
          icon: Icon(Icons.menu_book_rounded),
          label: 'List',
        ),
        NavigationDestination(
          icon: Icon(Icons.data_exploration),
          label: 'Data',
        ),
      ],
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
      title: const Text(
        'My Headaches',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }
}
