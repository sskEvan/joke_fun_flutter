import 'dart:convert';
import 'dart:math';

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

List<Map<String, dynamic>> _testVideoInfoList = [
  {
    "width": 960,
    "height": 540,
    "videoUrl":
        "https://stream7.iqilu.com/10339/upload_transcode/202002/09/20200209104902N3v5Vpxuvb.mp4"
  },
  {
    "width": 1920,
    "height": 1080,
    "videoUrl": "https://v-cdn.zjol.com.cn/280443.mp4"
  },
  {
    "width": 540,
    "height": 960,
    "videoUrl": "https://v-cdn.zjol.com.cn/276993.mp4"
  },
  {
    "width": 1920,
    "height": 1080,
    "videoUrl": "https://v-cdn.zjol.com.cn/276982.mp4"
  },
  {
    "width": 1920,
    "height": 1080,
    "videoUrl": "https://v-cdn.zjol.com.cn/276984.mp4"
  },
  {
    "width": 540,
    "height": 960,
    "videoUrl": "https://v-cdn.zjol.com.cn/276998.mp4"
  },
  {
    "width": 960,
    "height": 544,
    "videoUrl": "https://v-cdn.zjol.com.cn/276985.mp4"
  },
  {
    "width": 1920,
    "height": 1080,
    "videoUrl": "https://v-cdn.zjol.com.cn/276986.mp4"
  },
  {
    "width": 1920,
    "height": 1080,
    "videoUrl": "https://v-cdn.zjol.com.cn/276987.mp4"
  },
  {
    "width": 1920,
    "height": 1080,
    "videoUrl": "https://v-cdn.zjol.com.cn/276988.mp4"
  },
  {
    "width": 1920,
    "height": 1080,
    "videoUrl": "https://v-cdn.zjol.com.cn/276989.mp4"
  },
  {
    "width": 1920,
    "height": 1080,
    "videoUrl": "https://v-cdn.zjol.com.cn/276990.mp4"
  },
  {
    "width": 1920,
    "height": 1080,
    "videoUrl": "https://v-cdn.zjol.com.cn/276991.mp4"
  },
  {
    "width": 960,
    "height": 464,
    "videoUrl": "https://v-cdn.zjol.com.cn/276992.mp4"
  },
  {
    "width": 1920,
    "height": 1080,
    "videoUrl": "https://v-cdn.zjol.com.cn/276994.mp4"
  },
  {
    "width": 1920,
    "height": 1080,
    "videoUrl": "https://v-cdn.zjol.com.cn/277004.mp4"
  },
];

Map<String, dynamic> getTestVideoInfo() {
  return _testVideoInfoList[Random().nextInt(_testVideoInfoList.length)];
}
