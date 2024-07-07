// services/nfcService.dart

import 'dart:developer';

import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';

class NfcService {
  static readNFC() async {
    if (NFCAvailability.available == await FlutterNfcKit.nfcAvailability) {
      try {
        var tag = await FlutterNfcKit.poll(
          timeout: const Duration(seconds: 30),
          readIso18092: true,
          probeWebUSBMagic: true,
          androidCheckNDEF: true,
        );
        log("Nfc Tag : ${tag.protocolInfo}");

        var message = await FlutterNfcKit.readBlock(2);

        log("Nfc Tag 2 : ${message.toString()}");
        await FlutterNfcKit.finish();
      } catch (e) {
        log("exception: $e");
      }
    }
  }

  static writeNFC() async {
    var tag = await FlutterNfcKit.poll(
      timeout: const Duration(seconds: 30),
      readIso18092: true,
      probeWebUSBMagic: true,
      androidCheckNDEF: true,
    );

    if (NFCAvailability.available == await FlutterNfcKit.nfcAvailability) {
      log("Nfc Tag : ${tag.protocolInfo}");

      try {
        await FlutterNfcKit.writeBlock(2, "Hello World NFC");
        log("Nfc Tag 2 : ${await FlutterNfcKit.readBlock(2)}");
        await FlutterNfcKit.finish();
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
