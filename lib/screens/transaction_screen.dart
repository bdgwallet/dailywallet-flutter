import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dailywallet_flutter/ldknode_manager.dart';
import 'package:bitcoin_ui/bitcoin_ui.dart';

class TransactionScreen extends ConsumerWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ldkNodeManager = ref.watch(ldkNodeManagerProvider);
    return Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(ldkNodeManager.syncState.toString()),
      const Text("Wallet balance"),
      BitcoinButtonFilled(
          title: "Filled",
          onPressed: () {
            debugPrint("Test button press");
          }),
      const SizedBox(height: 16),
      BitcoinButtonFilled(
          title: "Filled disabled",
          disabled: true,
          onPressed: () {
            debugPrint("Test button press");
          }),
      const SizedBox(height: 16),
      BitcoinButtonFilled(
          title: "Filled disabled",
          isLoading: true,
          onPressed: () {
            debugPrint("Test button press");
          }),
      const SizedBox(height: 16),
      BitcoinButtonOutlined(
          title: "Outlined",
          onPressed: () {
            debugPrint("Test button press");
          }),
      const SizedBox(height: 16),
      BitcoinButtonOutlined(
          title: "Filled disabled",
          disabled: true,
          onPressed: () {
            debugPrint("Test button press");
          }),
      const SizedBox(height: 16),
      BitcoinButtonOutlined(
          title: "Filled disabled",
          isLoading: true,
          onPressed: () {
            debugPrint("Test button press");
          }),
      const SizedBox(height: 16),
      BitcoinButtonPlain(
          title: "Plain",
          onPressed: () {
            debugPrint("Test button press");
          }),
      const SizedBox(height: 16),
      BitcoinButtonPlain(
          title: "Outlined disabled",
          disabled: true,
          onPressed: () {
            debugPrint("Test button press");
          }),
      const SizedBox(height: 16),
      BitcoinButtonPlain(
          title: "Test",
          isLoading: true,
          onPressed: () {
            debugPrint("Test button press");
          }),
    ]));
  }
}
