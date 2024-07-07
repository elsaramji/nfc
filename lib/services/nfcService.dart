// services/nfcService.dart

import 'dart:developer';

import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

import 'package:ndef/record.dart';

class NfcService {
  static readNFC() async {
    if (NFCAvailability.available == await FlutterNfcKit.nfcAvailability) {
      try {
        var tag = await FlutterNfcKit.poll(
          timeout: const Duration(seconds: 5),
          readIso18092: true,
          probeWebUSBMagic: true,
          androidCheckNDEF: true,
        );
        log("Nfc Tag : " + tag.toString());
        if (tag.ndefAvailable!) {
          print('NDEF message available');
          // Process NDEF message
          List<NDEFRecord> records = await FlutterNfcKit.readNDEFRecords();
          log("Nfc Tag 1: " + records.toString());
        } else {
          var message = await FlutterNfcKit.transceive(tag);
          log("Nfc Tag 2 : " + message.toString());
        }
      } catch (e) {
        log("exception: " + e.toString());
      }
    }
  }
}
