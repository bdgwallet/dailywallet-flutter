import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bitcoin_icons/bitcoin_icons.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:dailywallet_flutter/ldknode_manager.dart';
import 'package:dailywallet_flutter/screens/transaction_screen.dart';
import 'package:dailywallet_flutter/screens/activity_screen.dart';
import 'package:dailywallet_flutter/screens/settings_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabState = ref.watch(tabStateProvider);
    final ldkNodeManager = ref.watch(ldkNodeManagerProvider);

    return PlatformScaffold(
      body: tabState.tabScreen(),
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavBar: PlatformNavBar(
          currentIndex: tabState.selectedTab,
          itemChanged: (index) {
            tabState.updateIndex(index);
          },
          cupertino: (context, platform) => CupertinoTabBarData(
              border: Border.all(width: 0, color: Colors.transparent)),
          material3: (context, platform) => MaterialNavigationBarData(
              elevation: 0,
              backgroundColor: Theme.of(context).colorScheme.background,
              indicatorColor: Theme.of(context).colorScheme.background),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(BitcoinIcons.flip_vertical), label: "Payments"),
            BottomNavigationBarItem(
                icon: Icon(BitcoinIcons.transactions), label: "Activity"),
            BottomNavigationBarItem(
                icon: Icon(BitcoinIcons.gear), label: "Settings")
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
