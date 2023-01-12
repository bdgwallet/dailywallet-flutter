import 'package:flutter/material.dart';
import 'package:bdk_flutter/bdk_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BDKManager extends ChangeNotifier {
  BDKManager(this.databaseConfig, this.blockchainConfig);

  Wallet? wallet;
  Balance? balance;
  var transactions = <TransactionDetails>[];
  var syncState = SyncState.empty;

  final DatabaseConfig databaseConfig;
  final BlockchainConfig blockchainConfig;

  Future<void> signOut() {
    // update state
    user = null;
    // and notify any listeners
    notifyListeners();
  }
}

final bdkManagerProvider = ChangeNotifierProvider<BDKManager>((ref) {
  return BDKManager();
});

enum SyncState { empty, syncing, synced, failed }
