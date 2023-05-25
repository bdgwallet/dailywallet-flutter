import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ldk_node/ldk_node.dart' as LDK;
import 'package:path_provider/path_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ldkNodeManagerProvider = ChangeNotifierProvider<LDKNodeManager>((ref) {
  return LDKNodeManager(LDK.Network.Testnet); // Set to .Bitcoin or .Testnet
});

class LDKNodeManager extends ChangeNotifier {
  late LDK.Network network;
  LDK.Node? node;
  var syncState = SyncState.empty;

  LDKNodeManager(this.network) {
    network = network;
  }

  start(String mnemonic) async {
    try {
      final nodeConfig = LDK.Config(
          storageDirPath: await appDirectoryPath(),
          esploraServerUrl: network == LDK.Network.Bitcoin
              ? ESPLORA_URL_BITCOIN
              : ESPLORA_URL_TESTNET,
          network: network,
          listeningAddress: DEFAULT_LISTENING_ADDRESS,
          defaultCltvExpiryDelta: DEFAULT_CLTV_EXPIRY_DELTA);
      LDK.Builder builder = LDK.Builder.fromConfig(config: nodeConfig);
      builder.setEntropyBip39Mnemonic(mnemonic: mnemonic);
      node = await builder.build();
      await node?.start();
      notifyListeners();
      sync();
    } on Exception catch (error) {
      debugPrint(error.toString());
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

const DEFAULT_LISTENING_ADDRESS = LDK.SocketAddr(ip: "0.0.0.0", port: 9735);
const DEFAULT_CLTV_EXPIRY_DELTA = 2048;
