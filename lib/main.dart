import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:dailywallet_flutter/bdkmanager.dart';
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
            : const CreateWalletScreen(),
      ),
    );
  }
}
