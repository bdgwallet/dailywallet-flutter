import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:dailywallet_flutter/bdkmanager.dart';

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
