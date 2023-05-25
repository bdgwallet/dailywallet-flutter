import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:dailywallet_flutter/ldknodemanager.dart';
import 'package:dailywallet_flutter/keymanager.dart';
import 'package:dailywallet_flutter/screens/createwallet_screen.dart';
import 'package:dailywallet_flutter/screens/home_screen.dart';

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
        home: PlatformScaffold(
            body: ldkNodeManager.node != null
                ? const HomeScreen()
                : FutureBuilder(
                    future: checkForExistingWallet(ref),
                    builder: ((context, snapshot) {
                      if (snapshot.hasData) {
                        return snapshot.data != false
                            ? const HomeScreen()
                            : const CreateWalletScreen();
                      } else {
                        return Center(
                            child: PlatformCircularProgressIndicator());
                      }
                    }))));
  }
}

Future<bool> checkForExistingWallet(WidgetRef ref) async {
  final ldkNodeManager = ref.watch(ldkNodeManagerProvider);
  try {
    await getKeyData().then((keydata) async {
      ldkNodeManager.start(keydata.mnemonic);
    });
    return true;
  } catch (error) {
    debugPrint(error.toString());
  }
  return false;
}
