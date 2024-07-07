// services/nfcService.dart

import 'dart:developer';

import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

class NfcService {
  static readNFC() async {
    if (NFCAvailability.available == await FlutterNfcKit.nfcAvailability) {
      try {
        var tag = await FlutterNfcKit.poll(
          timeout: const Duration(seconds: 5),
          readIso18092: true,
          probeWebUSBMagic: true,
        );
        log("Nfc Tag : " + tag.toJson().toString());
      } catch (e) {
        log("exception: " + e.toString());
      }
    }
  }
}
