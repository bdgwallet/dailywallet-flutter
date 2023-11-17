import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:dailywallet_flutter/ldknode_manager.dart';
import 'package:dailywallet_flutter/key_manager.dart';
import 'package:dailywallet_flutter/screens/onboarding/start_screen.dart';
import 'package:dailywallet_flutter/screens/home_screen.dart';
import 'package:ldk_node/ldk_node.dart';

void main() {
  runApp(
    const ProviderScope(
      child: DailyWalletApp(),
    ),
  );
}

class DailyWalletApp extends ConsumerWidget {
  const DailyWalletApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ldkNodeManager = ref.watch(ldkNodeManagerProvider);

    return PlatformApp(
        debugShowCheckedModeBanner: false,
        material: (context, platform) => MaterialAppData(),
        cupertino: (context, platform) => CupertinoAppData(),
        home: PlatformScaffold(
            body: ldkNodeManager.node != null
                ? const HomeScreen()
                : FutureBuilder(
                    future: existingWallet(ref),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data == true
                            ? const HomeScreen()
                            : const StartScreen();
                      } else {
                        return Center(
                            child: PlatformCircularProgressIndicator());
                      }
                    }))));
  }
}

Future<bool> existingWallet(WidgetRef ref) async {
  final ldkNodeManager = ref.watch(ldkNodeManagerProvider);
  //await deleteKeyData();
  try {
    await getKeyData().then((keydata) async {
      ldkNodeManager.start(Mnemonic(internal: keydata.mnemonic));
    });
    return true;
  } catch (error) {
    debugPrint(error.toString());
  }
  return false;
}
