import 'dart:async';
import 'package:flutter/material.dart';
import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final bdkManagerProvider = ChangeNotifierProvider<BDKManager>((ref) {
  return BDKManager(Network.Testnet);
});

class BDKManager extends ChangeNotifier {
  BDKManager(this.network);

  Network network;
  Wallet? wallet;
  Balance? balance;
  var transactions = <TransactionDetails>[];
  var syncState = SyncState.empty;

  final databaseConfig = const DatabaseConfig.memory();
  final blockchainConfig = BlockchainConfig.electrum(
      config: ElectrumConfig(
          stopGap: 10,
          timeout: 5,
          retry: 5,
          url: "ssl://electrum.blockstream.info:60002"));

  Future<List<String>> getDescriptors(Mnemonic mnemonic) async {
    final descriptors = <String>[];
    try {
      for (var e in ["m/84'/1'/0'/0", "m/84'/1'/0'/1"]) {
        final descriptorSecretKey = await DescriptorSecretKey.create(
          network: Network.Testnet,
          mnemonic: mnemonic,
        );
        final derivationPath = await DerivationPath.create(path: e);
        final derivedXprv = await descriptorSecretKey.derive(derivationPath);
        final derivedXprvStr = await derivedXprv.asString();
        descriptors.add("wpkh($derivedXprvStr)");
      }
      return descriptors;
    } on Exception catch (error) {
      debugPrint(error.toString());
      rethrow;
    }
  }

  loadWallet() async {
    final mnemonic = await Mnemonic.create(WordCount.Words12);
    try {
      final descriptors = await getDescriptors(mnemonic);
      wallet = await Wallet.create(
          descriptor: descriptors[0],
          changeDescriptor: descriptors[1],
          network: network,
          databaseConfig: databaseConfig);
      notifyListeners();
    } on Exception catch (error) {
      debugPrint(error.toString());
    }
  }
}

enum SyncState { empty, syncing, synced, failed }
