import 'dart:convert';

import 'package:encrypt/encrypt.dart';

String decodeMediaUrl(String? content) {
  if (content == null) {
    return "";
  }
  if (content.startsWith("ftp://")) {
    try {
      final encryptedString =
          content.substring("ftp://".length, content.length);
      String key = "cretinzp**273846";

      final encryptedBytes = base64.decode(encryptedString);
      final iv = IV.fromUtf8(key);
      final encrypter = Encrypter(AES(Key.fromUtf8(key), mode: AESMode.ecb));

      final decrypted =
          encrypter.decryptBytes(Encrypted(encryptedBytes), iv: iv);
      final decryptedString = utf8.decode(decrypted);
      return decryptedString;
    } catch (e) {
      return content;
    }
  } else {
    return content;
  }
}
