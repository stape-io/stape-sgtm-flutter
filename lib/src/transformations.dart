import 'dart:convert';

import 'package:crypto/crypto.dart';

String base64Encode(String value) {
  return base64.encode(utf8.encode(value));
}

String trim(String value) {
  return value.trim();
}

String sha256base64Encode(String value) {
  return base64.encode(sha256.convert(utf8.encode(value.trim().toLowerCase())).bytes);
}

String sha256Encode(String value) {
  return sha256.convert(utf8.encode(value.trim().toLowerCase())).toString();
}

String md5Encode(String value) {
  return md5.convert(utf8.encode(value.trim().toLowerCase())).toString();
}

String toLowerCase(String value) {
  return value.trim().toLowerCase();
}
