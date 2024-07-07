// nfcService.dart


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
        print(tag.toJson());
      } catch (e) {
        print(e.toString());
      }
    }
  }

  static writeNFC() async {
    if (NFCAvailability.available == await FlutterNfcKit.nfcAvailability) {
      try {
         var response = await FlutterNfcKit.transceive(
         "Hello Dart!",
          timeout: const Duration(seconds: 5),
        );
        print(response);
      } catch (e) {
        print(e.toString());
      }
    }
  }
}