import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ldk_node/ldk_node.dart' as ldk_node;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ldkNodeManagerProvider = ChangeNotifierProvider<LDKNodeManager>((ref) {
  return LDKNodeManager(
      ldk_node.Network.Testnet); // Set to .Bitcoin or .Testnet
});

class LDKNodeManager extends ChangeNotifier {
  late ldk_node.Network network;
  ldk_node.Node? node;
  var syncState = SyncState.empty;

  LDKNodeManager(this.network) {
    network = network;
  }

  Future<bool> start(ldk_node.Mnemonic mnemonic) async {
    final directory = await getApplicationDocumentsDirectory();
    final nodePath = "${directory.path}/ldk_cache/";
    try {
      final nodeConfig = ldk_node.Config(
          trustedPeers0Conf: [],
          storageDirPath: nodePath,
          network: ldk_node.Network.Testnet,
          listeningAddress:
              const ldk_node.NetAddress.iPv4(addr: "0.0.0.0", port: 3006),
          onchainWalletSyncIntervalSecs: 60,
          walletSyncIntervalSecs: 20,
          feeRateCacheUpdateIntervalSecs: 600,
          logLevel: ldk_node.LogLevel.Debug,
          defaultCltvExpiryDelta: 144,
          probingLiquidityLimitMultiplier: 3
          /* storageDirPath: await appDirectoryPath(),
          network: network,
          onchainWalletSyncIntervalSecs: 30,
          walletSyncIntervalSecs: 30,
          feeRateCacheUpdateIntervalSecs: 100,
          logLevel: ldk_node.LogLevel.info,
          defaultCltvExpiryDelta: 144,
          trustedPeers0Conf: [] */
          );
      ldk_node.Builder builder =
          ldk_node.Builder.fromConfig(config: nodeConfig);
      await ldk_node.Mnemonic.generate().then((mnemonic) async {
        builder.setEntropyBip39Mnemonic(mnemonic: mnemonic);
        node = await builder.build();
        await node?.start();
        notifyListeners();
        sync();
        return Future.value(true);
      });
      return Future.value(false);
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
        await node?.syncWallets();
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

Future<String> appDirectoryPath() async {
  Directory appDocumentsDirectory =
      await getApplicationDocumentsDirectory(); // 1
  return appDocumentsDirectory.path;
}

// Public API URLs
const ESPLORA_URL_BITCOIN = "https://blockstream.info/api/";
const ESPLORA_URL_TESTNET = "https://blockstream.info/testnet/api";

const ELECTRUM_URL_BITCOIN = "ssl://electrum.blockstream.info:60001";
const ELECTRUM_URL_TESTNET = "ssl://electrum.blockstream.info:60002";

const DEFAULT_LISTENING_ADDRESS =
    ldk_node.NetAddress.iPv4(addr: "0.0.0.0", port: 3006);
const DEFAULT_CLTV_EXPIRY_DELTA = 2048;
