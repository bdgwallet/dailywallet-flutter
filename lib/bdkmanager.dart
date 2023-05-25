// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:bdk_flutter/bdk_flutter.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// final bdkManagerProvider = ChangeNotifierProvider<BDKManager>((ref) {
//   return BDKManager(Network.Testnet);
// });

// class BDKManager extends ChangeNotifier {
//   Network network;
//   Wallet? wallet;
//   Balance? balance;
//   var transactions = <TransactionDetails>[];
//   var syncState = SyncState.empty;

//   final databaseConfig = const DatabaseConfig.memory();
//   late BlockchainConfig blockchainConfig;

//   BDKManager(this.network) {
//     blockchainConfig = BlockchainConfig.electrum(
//         config: ElectrumConfig(
//             stopGap: 10,
//             timeout: 5,
//             retry: 5,
//             url: network == Network.Bitcoin
//                 ? ELECTRUM_URL_BITCOIN
//                 : ELECTRUM_URL_TESTNET,
//             validateDomain: true));
//   }

//   loadWallet(Descriptor descriptor, Descriptor? changeDescriptor) async {
//     try {
//       wallet = await Wallet.create(
//           descriptor: descriptor,
//           changeDescriptor: changeDescriptor,
//           network: network,
//           databaseConfig: databaseConfig);
//       notifyListeners();
//     } on Exception catch (error) {
//       debugPrint(error.toString());
//     }
//   }

//   sync() async {
//     if (wallet != null) {
//       syncState = SyncState.syncing;
//       notifyListeners();
//       try {
//         final blockchain = await Blockchain.create(config: blockchainConfig);
//         await wallet!.sync(blockchain);
//         syncState = SyncState.synced;
//         notifyListeners();
//       } on Exception catch (error) {
//         syncState = SyncState.failed;
//         notifyListeners();
//         debugPrint(error.toString());
//       }
//     }
//   }

//   Future<List<String>> getDescriptors(Mnemonic mnemonic) async {
//     final descriptors = <String>[];
//     try {
//       for (var e in ["m/84'/1'/0'/0", "m/84'/1'/0'/1"]) {
//         final descriptorSecretKey = await DescriptorSecretKey.create(
//           network: network,
//           mnemonic: mnemonic,
//         );
//         final derivationPath = await DerivationPath.create(path: e);
//         final derivedXprv = await descriptorSecretKey.derive(derivationPath);
//         final derivedXprvStr = await derivedXprv.asString();
//         descriptors.add("wpkh($derivedXprvStr)");
//       }
//       return descriptors;
//     } on Exception catch (error) {
//       debugPrint(error.toString());
//       rethrow;
//     }
//   }
// }

// enum SyncState { empty, syncing, synced, failed }

// // Public API URLs
// const ESPLORA_URL_BITCOIN = "https://blockstream.info/api/";
// const ESPLORA_URL_TESTNET = "https://blockstream.info/testnet/api";

// const ELECTRUM_URL_BITCOIN = "ssl://electrum.blockstream.info:60001";
// const ELECTRUM_URL_TESTNET = "ssl://electrum.blockstream.info:60002";
