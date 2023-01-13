import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

    if (Platform.isIOS) {
      return CupertinoApp(
        home: CupertinoPageScaffold(
          child: bdkManager.wallet != null
              ? const HomeScreen()
              : const CreateWalletScreen(),
        ),
        debugShowCheckedModeBanner: false,
      );
    } else {
      return MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: Scaffold(
            body: bdkManager.wallet != null
                ? const HomeScreen()
                : const CreateWalletScreen()),
      );
    }
  }
}
