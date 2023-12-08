import 'package:bitcoin_ui/bitcoin_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dailywallet_flutter/ldknode_manager.dart';
import 'package:dailywallet_flutter/themes/dailywallet_themes.dart';

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ldkNodeManager = ref.watch(ldkNodeManagerProvider);
    return Container(
        margin: platformInsets(InsetSize.large),
        child: const Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [BalanceHeader(), ActivityList()]));
  }
}

class BalanceHeader extends ConsumerWidget {
  const BalanceHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ldkNodeManager = ref.watch(ldkNodeManagerProvider);
    return Padding(
      padding: const EdgeInsets.all(48.0),
      child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Your balance", style: Theme.of(context).textTheme.titleSmall),
        Text(ldkNodeManager.totalOnchainBalance.toString() + " sats",
            style: Theme.of(context).textTheme.headlineMedium),
        Text("\$0", style: Theme.of(context).textTheme.titleSmall),
      ])),
    );
  }
}

class ActivityList extends ConsumerWidget {
  const ActivityList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ldkNodeManager = ref.watch(ldkNodeManagerProvider);
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Activity", style: Theme.of(context).textTheme.titleMedium),
          // List of transactions
        ]);
  }
}
