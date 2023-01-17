import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:dailywallet_flutter/bdkmanager.dart';

class ActivityScreen extends ConsumerWidget {
  const ActivityScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bdkManager = ref.watch(bdkManagerProvider);
    return Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
          Text("Activity screen"),
        ]));
  }
}
