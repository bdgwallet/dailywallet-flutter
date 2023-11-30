import 'package:bitcoin_ui/bitcoin_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dailywallet_flutter/ldknode_manager.dart';

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ldkNodeManager = ref.watch(ldkNodeManagerProvider);
    return const Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("Activity screen"),
    ]));
  }
}
