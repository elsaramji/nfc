// services/nfcService.dart

import 'dart:developer';

import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

import 'package:ndef/record.dart';
import 'package:nfc_manager/nfc_manager.dart';

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
          var message =
              await FlutterNfcKit.readBlock(0, iso15693ExtendedMode: true);
          log("Nfc Tag 2 : " + message.toString());
        }
      } catch (e) {
        log("exception: " + e.toString());
      }
    }
  }

  static writeNFC() async {
    var tag = await FlutterNfcKit.poll(
      timeout: const Duration(seconds: 5),
      readIso18092: true,
      probeWebUSBMagic: true,
      androidCheckNDEF: true,
    );

    if (NFCAvailability.available == await FlutterNfcKit.nfcAvailability) {
      log("Nfc Tag : " + tag.protocolInfo.toString());
      try {
        await FlutterNfcKit.writeBlock(0, "Hello World NFC");

        /*
         await FlutterNfcKit.transceive(
          "Send 1000", 
          timeout: const Duration(seconds: 5),
        );*/
      } catch (e) {
        print(e.toString());
      }
    }
  }
}
