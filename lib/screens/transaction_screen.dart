import 'package:flutter/material.dart';

import 'package:bitcoin_ui/bitcoin_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:dailywallet_flutter/themes/dailywallet_themes.dart';
import 'package:dailywallet_flutter/widgets/numeric_keypad.dart';

class TransactionScreen extends ConsumerWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
        margin: platformInsets(InsetSize.large),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(),
                // Amount
                Padding(
                  padding: const EdgeInsets.all(72.0),
                  child: Column(
                    children: [
                      Text("0 sats",
                          style: Theme.of(context).textTheme.headlineMedium),
                      Text("\$0",
                          style: Theme.of(context).textTheme.titleSmall),
                    ],
                  ),
                ),
                // Numpad
                const Spacer(),
                NumPad(),
                const Spacer(),
                // Buttons
                Row(
                  children: [
                    BitcoinButtonFilled(
                      title: "Receive",
                      height: 64,
                      width: 148,
                      onPressed: () {
                        //
                      },
                    ),
                    const Spacer(),
                    BitcoinButtonFilled(
                      title: "Send",
                      height: 64,
                      width: 148,
                      onPressed: () {
                        //
                      },
                    ),
                  ],
                )
              ]),
        ));
  }
}
