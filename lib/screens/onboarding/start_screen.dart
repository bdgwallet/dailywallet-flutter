import 'package:flutter/material.dart';

import 'package:bitcoin_ui/bitcoin_ui.dart';
import 'package:dailywallet_flutter/ldknode_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dailywallet_flutter/screens/onboarding/createwallet_screen.dart';
import 'package:dailywallet_flutter/screens/onboarding/restorewallet_screen.dart';

class StartScreen extends ConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ldkNodeManager = ref.watch(ldkNodeManagerProvider);

    return Container(
        margin: const EdgeInsets.fromLTRB(32, 64, 32, 32),
        child: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Spacer(),
          Image(
              image: const AssetImage("icons/bitcoin_circle.png",
                  package: "bitcoin_ui"),
              height: 125,
              fit: BoxFit.fill,
              color: Bitcoin.orange),
          const SizedBox(height: 16),
          Text("Bitcoin Wallet", style: BitcoinTextStyle.title1(Bitcoin.black)),
          const SizedBox(height: 16),
          Text(
            "A simple bitcoin wallet for your enjoyment",
            style: BitcoinTextStyle.body1(Bitcoin.neutral7),
            textAlign: TextAlign.center,
          ),
          const Spacer(),
          BitcoinButtonFilled(
            title: "Create wallet",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const CreateWalletScreen()));
            },
          ),
          const SizedBox(height: 16),
          BitcoinButtonPlain(
            title: "Restore wallet",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RestoreWalletScreen()));
            },
          ),
          const SizedBox(height: 16),
          Text(
            "Your wallet, your coins\n100% open-source & open-design",
            style: BitcoinTextStyle.body4(Bitcoin.neutral7),
            textAlign: TextAlign.center,
          ),
        ])));
  }
}
