import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ldk_node/ldk_node.dart';
import 'package:bitcoin_ui/bitcoin_ui.dart';
import 'package:dailywallet_flutter/ldknode_manager.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dailywallet_flutter/key_manager.dart';

class CreateWalletScreen extends ConsumerWidget {
  const CreateWalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ldkNodeManager = ref.watch(ldkNodeManagerProvider);
    final switchOneState = ref.watch(switchOneStateProvider);
    final switchTwoState = ref.watch(switchTwoStateProvider);

    return PlatformScaffold(
      appBar: PlatformAppBar(
          //title: const Text("Settings"),
          cupertino: (context, platform) => CupertinoNavigationBarData(
              backgroundColor: Colors.transparent,
              border: Border.all(color: Colors.transparent),
              leading: CupertinoNavigationBarBackButton(
                  color: Bitcoin.black, previousPageTitle: "Back")),
          material: ((context, platform) => MaterialAppBarData(
              backgroundColor: Colors.transparent,
              elevation: 0.1,
              leading: BackButton(color: Bitcoin.black)))),
      body: Container(
          margin: const EdgeInsets.fromLTRB(32, 64, 32, 32),
          child: Center(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                const Spacer(),
                Image(
                    image: const AssetImage("icons/wallet.png",
                        package: "bitcoin_ui"),
                    height: 60,
                    fit: BoxFit.fill,
                    color: Bitcoin.green),
                const SizedBox(height: 16),
                Text("Two things you\nmust understand",
                    style: BitcoinTextStyle.title2(Bitcoin.black),
                    textAlign: TextAlign.center),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "With bitcoin, you are your own bank. No on else has access to your private keys.",
                              style: BitcoinTextStyle.body3(Bitcoin.neutral7),
                              textAlign: TextAlign.left,
                              maxLines: 5,
                            ),
                          ),
                          const SizedBox(width: 8),
                          PlatformSwitch(
                            activeColor: Bitcoin.green,
                            value: switchOneState,
                            onChanged: (value) {
                              ref.read(switchOneStateProvider.notifier).state =
                                  value;
                            },
                          )
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: Text(
                              "If you lose access to this app, and the backup we will help you create, your bitcoin cannot be recovered.",
                              style: BitcoinTextStyle.body3(Bitcoin.neutral7),
                              textAlign: TextAlign.left,
                              maxLines: 5,
                            ),
                          ),
                          const SizedBox(width: 8),
                          PlatformSwitch(
                            activeColor: Bitcoin.green,
                            value: switchTwoState,
                            onChanged: (value) {
                              ref.read(switchTwoStateProvider.notifier).state =
                                  value;
                            },
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                BitcoinButtonFilled(
                  title: "Continue",
                  disabled: switchOneState == false || switchTwoState == false
                      ? true
                      : false,
                  onPressed: () async {
                    generateEntropyMnemonic().then((mnemonic) async {
                      final keydata = KeyData(mnemonic.internal);
                      saveKeyData(keydata);
                      bool started = await ldkNodeManager.start(mnemonic);
                      Navigator.pop(context);
                    });
                  },
                ),
                const SizedBox(height: 16),
                BitcoinButtonPlain(
                  title: "Advanced settings",
                  onPressed: () {
                    // TODO: Advanced settings
                    debugPrint("Advanced settings: Not yet implemented");
                    Navigator.pop(context);
                  },
                ),
              ]))),
    );
  }
}

final switchOneStateProvider = StateProvider<bool>((ref) {
  return false;
});

final switchTwoStateProvider = StateProvider<bool>((ref) {
  return false;
});
