import 'dart:math' show Random;
import 'dart:convert' show utf8, base64;
import 'dart:typed_data' show Uint8List;
import 'package:convert/convert.dart' show hex;
import 'package:crypto/crypto.dart' show Hmac, sha1;

final List<int> prefix = [25];
final List<int> sigKey = [223, 165, 237, 25, 45, 218, 110, 136, 161, 47, 225, 33, 48, 220, 98, 6, 177, 37, 30, 68];
final List<int> deviceKey = [231, 48, 158, 204, 9, 83, 198, 250, 96, 0, 91, 39, 101, 249, 157, 187, 201, 101, 200, 233];


Uint8List randomUint8List(int length) {
  assert(length > 0);

  final random = Random();
  final ret = Uint8List(length);

  for (int i = 0; i < length; i++) {
    ret[i] = random.nextInt(256);
  }

  return ret;
}

String genDeviceId() {
  final List<int> identifier = [...prefix, ...randomUint8List(20)];
  final mac = Hmac(sha1, deviceKey).convert(identifier);
  return '${hex.encode(identifier)}${hex.encode(mac.bytes)}'.toUpperCase();
}

String genSignature(String data) {
  final List<int> bytesData = utf8.encode(data);
  final mac = Hmac(sha1, sigKey).convert(bytesData);
  return base64.encode([...prefix, ...mac.bytes]);
}