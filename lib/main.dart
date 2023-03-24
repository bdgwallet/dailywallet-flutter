import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:dailywallet_flutter/bdkmanager.dart';
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
    final bdkManager = ref.watch(bdkManagerProvider);

    return PlatformApp(
        debugShowCheckedModeBanner: false,
        home: PlatformScaffold(
            body: bdkManager.wallet != null
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
  final bdkManager = ref.watch(bdkManagerProvider);

  try {
    await getKeyData().then((keydata) async {
      await Descriptor.create(
              descriptor: keydata.descriptor, network: bdkManager.network)
          .then((descriptor) async {
        await bdkManager.loadWallet(descriptor, null).then((result) {
          bdkManager.sync();
          return true;
        });
      });
    });
  } catch (error) {
    debugPrint(error.toString());
  }
  return false;
}
