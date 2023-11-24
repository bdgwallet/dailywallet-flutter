import 'package:dailywallet_flutter/themes/dailywallet_themes.dart';
import 'package:flutter/material.dart';

import 'package:bitcoin_ui/bitcoin_ui.dart';
import 'package:dailywallet_flutter/ldknode_manager.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dailywallet_flutter/screens/onboarding/createwallet_screen.dart';
import 'package:dailywallet_flutter/screens/onboarding/restorewallet_screen.dart';

class StartScreen extends ConsumerWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PlatformScaffold(
        body: Container(
            margin: platformInsets(InsetSize.large),
            child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  const Spacer(),
                  Image(
                      image: const AssetImage("icons/bitcoin_circle.png",
                          package: "bitcoin_ui"),
                      height: 60,
                      fit: BoxFit.fill,
                      color: Theme.of(context).colorScheme.primary),
                  const SizedBox(height: 16),
                  Text("Bitcoin wallet",
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: 16),
                  Text(
                    "A simple bitcoin wallet\nfor daily use",
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Bitcoin.neutral7),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  BitcoinButtonFilled(
                    title: "Create wallet",
                    height: 64,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const CreateWalletScreen()));
                    },
                  ),
                  const SizedBox(height: 16),
                  BitcoinButtonPlain(
                    title: "Restore wallet",
                    height: 64,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const RestoreWalletScreen()));
                    },
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Your wallet, your coins\n100% open-source & open-design",
                    style: BitcoinTextStyle.body4(Bitcoin.neutral7),
                    textAlign: TextAlign.center,
                  ),
                ]))));
  }
}
