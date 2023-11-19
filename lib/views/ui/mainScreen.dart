import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes/controllers/mainscreen_provider.dart';
import '../shared/shared.dart';
import 'ui.dart';

// ignore: must_be_immutable
class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  List<Widget> pageList = [
    const HomePage(),
    const SearchPage(),
    const Favorites(),
    const ProfilePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<MainScreenNotifier>(
        builder: (context, mainScreenNotifier, child) {
      return Scaffold(
        backgroundColor: const Color(0xFFE2E2E2),
        body: pageList[mainScreenNotifier.pageIndex],
        bottomNavigationBar: const BottomNavBar(),
      );
    });
  }
}
