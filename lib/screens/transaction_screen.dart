import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:dailywallet_flutter/ldknodemanager.dart';

class TransactionScreen extends ConsumerWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ldkNodeManager = ref.watch(ldkNodeManagerProvider);
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(ldkNodeManager.syncState.toString()),
      const Text("Wallet balance"),
    ]));
  }
}
