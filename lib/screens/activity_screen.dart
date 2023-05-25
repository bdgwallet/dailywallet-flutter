import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

import 'package:dailywallet_flutter/ldknode_manager.dart';

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ldkNodeManager = ref.watch(ldkNodeManagerProvider);
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
          Text("Activity screen"),
        ]));
  }
}
