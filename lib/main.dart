import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:dailywallet_flutter/themes/dailywallet_themes.dart';
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

    // Set statusbar colors correctly
    if (Theme.of(context).brightness == Brightness.dark) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Theme.of(context).colorScheme.background,
      ));
    } else {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Theme.of(context).colorScheme.background,
      ));
    }

    return PlatformProvider(
      settings: PlatformSettingsData(
          iosUsesMaterialWidgets: true,
          iosUseZeroPaddingForAppbarPlatformIcon: true),
      builder: (context) => PlatformTheme(
        themeMode: ThemeMode.system,
        materialLightTheme: materialLightTheme(context),
        cupertinoLightTheme: cupertinoLightTheme(context),
        builder: (context) => PlatformApp(
          debugShowCheckedModeBanner: false,
          title: 'BDG Daily Wallet',
          home: ldkNodeManager.node != null
              ? const HomeScreen()
              : FutureBuilder(
                  future: existingWallet(ref),
                  builder: ((context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data == true
                          ? const HomeScreen()
                          : const StartScreen();
                    } else {
                      return Center(child: PlatformCircularProgressIndicator());
                    }
                  })),
        ),
      ),
    );
  }
}

Future<bool> existingWallet(WidgetRef ref) async {
  final ldkNodeManager = ref.watch(ldkNodeManagerProvider);
  //Warning! only use when developing
  //await deleteKeyData();
  //await ldkNodeManager.deleteNodeData();
  try {
    await getKeyData().then((keydata) async {
      ldkNodeManager.start(Mnemonic(keydata.mnemonic));
    });
    return true;
  } catch (error) {
    debugPrint(error.toString());
  }
  return false;
}
