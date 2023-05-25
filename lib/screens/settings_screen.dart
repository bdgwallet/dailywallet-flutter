import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:dailywallet_flutter/ldknodemanager.dart';
import 'package:bitcoin_ui_kit/bitcoin_ui_kit.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ldkNodeManager = ref.watch(ldkNodeManagerProvider);
    return PlatformScaffold(
      appBar: PlatformAppBar(
          title: const Text("Settings"),
          cupertino: (context, platform) =>
              CupertinoNavigationBarData(backgroundColor: Colors.transparent),
          material: ((context, platform) => MaterialAppBarData(
              backgroundColor: Colors.transparent, elevation: 0.1))),
      body: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const Text("Settings screen"),
        Image(
            image: const AssetImage("icons/bitcoin_circle_filled.png",
                package: "bitcoin_ui_kit"),
            color: BitcoinUIKitColor.orange),
      ])),
    );
  }
}
