import 'package:flutter/material.dart';

import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dailywallet_flutter/bdkmanager.dart';
import 'package:dailywallet_flutter/keymanager.dart';

class CreateWalletScreen extends ConsumerWidget {
  const CreateWalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bdkManager = ref.watch(bdkManagerProvider);

    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      const Text("Sign in screen"),
      PlatformElevatedButton(
        child: const Text("Create wallet"),
        onPressed: () {
          Mnemonic.create(WordCount.Words12).then((mnemonic) {
            DescriptorSecretKey.create(
                    network: bdkManager.network, mnemonic: mnemonic)
                .then((descriptorSecretKey) {
              Descriptor.newBip84(
                      secretKey: descriptorSecretKey,
                      network: bdkManager.network,
                      keychain: KeychainKind.External)
                  .then((descriptor) {
                descriptor.asString().then((descriptorString) {
                  final keydata =
                      KeyData(mnemonic.asString(), descriptorString);
                  saveKeyData(keydata);
                  bdkManager.loadWallet(descriptor, null).then((result) {
                    bdkManager.sync();
                  });
                });
              });
            });
          });
        },
      ),
    ]));
  }
}
