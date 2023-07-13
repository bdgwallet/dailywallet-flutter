import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class KeyData {
  String mnemonic;
  String? descriptor;
  KeyData(this.mnemonic, [this.descriptor]);

  factory KeyData.fromJson(Map<String, dynamic> json) {
    return KeyData(json['mnemonic'], json['descriptor']);
  }

  Map<String, dynamic> toJson() => {
        'mnemonic': mnemonic.toString(),
        'descriptor': descriptor.toString(),
      };
}

void saveKeyData(KeyData keydata) async {
  final storage =
      FlutterSecureStorage(aOptions: androidOptions, iOptions: iosOptions);
  String jsonKeyData = jsonEncode(keydata);
  debugPrint("Save: $jsonKeyData");
  await storage.write(key: "keydata", value: jsonKeyData);
}

Future<KeyData> getKeyData() async {
  final storage =
      FlutterSecureStorage(aOptions: androidOptions, iOptions: iosOptions);
  KeyData? keydata;
  try {
    await storage.read(key: "keydata").then((jsonString) {
      if (jsonString != null) {
        debugPrint("Get: $jsonString");
        final keyDataMap = jsonDecode(jsonString);
        keydata = KeyData.fromJson(keyDataMap);
      }
    });
  } catch (error) {
    debugPrint(error.toString());
    rethrow;
  }
  if (keydata != null) {
    return keydata!;
  } else {
    throw Exception();
  }
}

// WARNING, only use while testing
Future<bool> deleteKeyData() async {
  final storage =
      FlutterSecureStorage(aOptions: androidOptions, iOptions: iosOptions);
  debugPrint("Delete keydata!");
  await storage.delete(key: "keydata");
  return true;
}

// Secure storage options

AndroidOptions androidOptions = const AndroidOptions(
  encryptedSharedPreferences: true,
);
IOSOptions iosOptions =
    const IOSOptions(accessibility: KeychainAccessibility.unlocked);
