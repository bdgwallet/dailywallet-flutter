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
  int currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
              backgroundColor: Colors.transparent,
              activeColor: Colors.orange,
              border: null,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.home), label: "Payments"),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.search), label: "Activity"),
                BottomNavigationBarItem(
                    icon: Icon(CupertinoIcons.settings), label: "Settings")
              ]),
          tabBuilder: (context, index) {
            switch (index) {
              case 0:
                return const TransactionScreen();
              case 1:
                return const ActivityScreen();
              case 2:
                return const SettingsScreen();
              default:
                return const TransactionScreen();
            }
          });
    } else {
      List<Widget> tabs = [
        const TransactionScreen(),
        const ActivityScreen(),
        const SettingsScreen(),
      ];
      onTapped(int index) {
        setState(() {
          currentTabIndex = index;
        });
      }

      return Scaffold(
        body: tabs[currentTabIndex],
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentTabIndex,
            onTap: onTapped,
            elevation: 0.0,
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "Payments"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "Activity"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings")
            ]),
      );
    }
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
