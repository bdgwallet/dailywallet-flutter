import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:bitcoin_ui_kit/bitcoin_ui_kit.dart';
import 'package:dailywallet_flutter/ldknode_manager.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class RestoreWalletScreen extends ConsumerWidget {
  const RestoreWalletScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ldkNodeManager = ref.watch(ldkNodeManagerProvider);

    return PlatformScaffold(
      appBar: PlatformAppBar(
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
                        package: "bitcoin_ui_kit"),
                    height: 60,
                    fit: BoxFit.fill,
                    color: Bitcoin.green),
                const SizedBox(height: 16),
                Text("Restore wallet",
                    style: BitcoinTextStyle.title2(Bitcoin.black),
                    textAlign: TextAlign.center),
                const Spacer(),
                Text(
                  "Not yet implemented",
                  style: BitcoinTextStyle.body3(Bitcoin.neutral7),
                  textAlign: TextAlign.center,
                  maxLines: 5,
                ),
                const Spacer(),
                BitcoinButtonFilled(
                  title: "Continue",
                  disabled: true,
                  onPressed: () {
                    // TODO: Restore wallet
                  },
                ),
                const SizedBox(height: 16),
              ]))),
    );
  }
}
