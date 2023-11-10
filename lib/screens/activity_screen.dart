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
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("Activity screen"),
      const SizedBox(height: 16),
      Text("Title 1", style: BitcoinTextStyle.title1(Bitcoin.black)),
      const SizedBox(height: 16),
      Text("Title 2", style: BitcoinTextStyle.title2(Bitcoin.black)),
      const SizedBox(height: 16),
      Text("Title 3", style: BitcoinTextStyle.title3(Bitcoin.black)),
      const SizedBox(height: 16),
      Text("Title 4", style: BitcoinTextStyle.title4(Bitcoin.black)),
      const SizedBox(height: 16),
      Text("Title 5", style: BitcoinTextStyle.title5(Bitcoin.black)),
      const SizedBox(height: 16),
      Text("Body 1", style: BitcoinTextStyle.body1(Bitcoin.black)),
      const SizedBox(height: 16),
      Text("Body 2", style: BitcoinTextStyle.body2(Bitcoin.black)),
      const SizedBox(height: 16),
      Text("Body 3", style: BitcoinTextStyle.body3(Bitcoin.black)),
      const SizedBox(height: 16),
      Text("Body 4", style: BitcoinTextStyle.body4(Bitcoin.black)),
      const SizedBox(height: 16),
      Text("Body 5", style: BitcoinTextStyle.body5(Bitcoin.black)),
    ]));
  }
}
