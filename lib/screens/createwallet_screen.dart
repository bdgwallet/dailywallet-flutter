import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:dailywallet_flutter/bdkmanager.dart';

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
              Descriptor.newBip44(
                      descriptorSecretKey: descriptorSecretKey,
                      network: bdkManager.network,
                      keyChainKind: KeychainKind.External)
                  .then((descriptor) {
                bdkManager.loadWallet(descriptor, null).then((result) {
                  bdkManager.sync();
                });
              });
            });
          });
        },
      ),
    ]));
  }
}
