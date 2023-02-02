import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:dailywallet_flutter/screens/transaction_screen.dart';
import 'package:dailywallet_flutter/screens/activity_screen.dart';
import 'package:dailywallet_flutter/screens/settings_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabState = ref.watch(tabStateProvider);

    return PlatformScaffold(
      body: tabState.tabScreen(),
      bottomNavBar: PlatformNavBar(
          backgroundColor: Colors.white,
          cupertino: (context, platform) => CupertinoTabBarData(
              border: Border.all(width: 0, color: Colors.transparent)),
          material: (context, platform) => MaterialNavBarData(elevation: 0.0),
          currentIndex: tabState.selectedTab,
          itemChanged: (index) {
            tabState.updateIndex(index);
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

final tabStateProvider = ChangeNotifierProvider<TabState>((ref) {
  return TabState();
});

class TabState extends ChangeNotifier {
  int selectedTab = 0;

  void updateIndex(int index) {
    selectedTab = index;
    notifyListeners();
  }

  Widget tabScreen() {
    switch (selectedTab) {
      case 1:
        return const ActivityScreen();
      case 2:
        return const SettingsScreen();
      default:
        return const TransactionScreen();
    }
  }
}
