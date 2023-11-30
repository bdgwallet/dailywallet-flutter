import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart' hide Builder;
import 'package:ldk_node/ldk_node.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Default values
const defaultListeningAddress = NetAddress.iPv4(addr: "0.0.0.0", port: 3006);
const defaultCltvExpiryDelta = 144;
const defaultOnchainWalletSyncIntervalSecs = 60;
const defaultWalletSyncIntervalSecs = 20;
const defaultFeeRateCacheUpdateIntervalSecs = 600;
const defaultProbingLiquidityLimitMultiplier = 3;

// Public API URLs
const esploraUrlBitcoin = "https://blockstream.info/api/";
const esploraUrlTestnet = "https://blockstream.info/testnet/api";

final ldkNodeManagerProvider = ChangeNotifierProvider<LDKNodeManager>((ref) {
  return LDKNodeManager(Network.Testnet); // Set to .Bitcoin or .Testnet
});

class LDKNodeManager extends ChangeNotifier {
  late Network network;
  Node? node;
  var syncState = SyncState.empty;

  LDKNodeManager(this.network) {
    network = network;
  }

  Future<bool> start(Mnemonic mnemonic) async {
    final applicationDirectory = await getApplicationDocumentsDirectory();
    final nodePath = "${applicationDirectory.path}/ldk_cache";
    // Warning, only use when developing
    //deleteNodeData(nodePath);
    try {
      final nodeConfig = Config(
          trustedPeers0Conf: [],
          storageDirPath: nodePath,
          network: network,
          listeningAddress: defaultListeningAddress,
          onchainWalletSyncIntervalSecs: defaultOnchainWalletSyncIntervalSecs,
          walletSyncIntervalSecs: defaultWalletSyncIntervalSecs,
          feeRateCacheUpdateIntervalSecs: defaultFeeRateCacheUpdateIntervalSecs,
          logLevel: LogLevel.Debug,
          defaultCltvExpiryDelta: defaultCltvExpiryDelta,
          probingLiquidityLimitMultiplier:
              defaultProbingLiquidityLimitMultiplier);
      Builder builder = Builder.fromConfig(config: nodeConfig);
      builder.setEntropyBip39Mnemonic(mnemonic: mnemonic);
      builder.setEsploraServer(
          esploraServerUrl: network == Network.Bitcoin
              ? esploraUrlBitcoin
              : esploraUrlTestnet);
      node = await builder.build();
      await node?.start();
      notifyListeners();
      sync();
      return Future.value(true);
    } on Exception catch (error) {
      debugPrint(error.toString());
      return Future.value(false);
    }
  }

  sync() async {
    if (node != null) {
      syncState = SyncState.syncing;
      notifyListeners();
      try {
        debugPrint("Sync started");
        await node?.syncWallets();
        debugPrint("Sync finished");
        syncState = SyncState.synced;
        notifyListeners();
      } on Exception catch (error) {
        syncState = SyncState.failed;
        notifyListeners();
        debugPrint(error.toString());
      }
    }
  }
}

enum SyncState { empty, syncing, synced, failed }

// Helpers
Future<String> appDirectoryPath() async {
  Directory appDocumentsDirectory =
      await getApplicationDocumentsDirectory(); // 1
  return appDocumentsDirectory.path;
}

void deleteNodeData(String nodePath) {
  final nodeDirectory = Directory(nodePath);
  nodeDirectory.deleteSync(recursive: true);
}
