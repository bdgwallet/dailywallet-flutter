import 'package:flutter/material.dart';

import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:dailywallet_flutter/ldknode_manager.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dailywallet_flutter/key_manager.dart';

class CreateWalletScreen extends ConsumerWidget {
  const CreateWalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ldkNodeManager = ref.watch(ldkNodeManagerProvider);

    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("Sign in screen"),
      PlatformElevatedButton(
        child: const Text("Create wallet"),
        onPressed: () {
          Mnemonic.create(WordCount.Words12).then((mnemonic) {
            final keydata = KeyData(mnemonic.asString());
            saveKeyData(keydata);
            ldkNodeManager.start(mnemonic.asString());
          });
        },
      ),
    ]));
  }
}
