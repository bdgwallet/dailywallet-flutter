import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:dailywallet_flutter/bdkmanager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _tabSelectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      body: getTabScreen(_tabSelectedIndex),
      bottomNavBar: PlatformNavBar(
          backgroundColor: Colors.white,
          cupertino: (context, platform) => CupertinoTabBarData(
              border: Border.all(width: 0, color: Colors.transparent)),
          material: (context, platform) => MaterialNavBarData(elevation: 0.0),
          currentIndex: _tabSelectedIndex,
          itemChanged: (index) {
            setState(() {
              _tabSelectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.home), label: "Payments"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.search), label: "Activity"),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings), label: "Settings")
          ]),
    );
  }
}

Widget getTabScreen(int tabIndex) {
  switch (tabIndex) {
    case 1:
      return const ActivityScreen();
    case 2:
      return const SettingsScreen();
    default:
      return const TransactionScreen();
  }
}

class TransactionScreen extends ConsumerWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bdkManager = ref.watch(bdkManagerProvider);
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(bdkManager.syncState.toString()),
      const Text("Wallet balance"),
    ]));
  }
}

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bdkManager = ref.watch(bdkManagerProvider);
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
          Text("Activity screen"),
        ]));
  }
}

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bdkManager = ref.watch(bdkManagerProvider);
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text("Settings"),
        cupertino: (context, platform) =>
            CupertinoNavigationBarData(backgroundColor: Colors.transparent),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
            Text("Settings screen"),
          ])),
    );
  }
}
