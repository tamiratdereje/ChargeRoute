import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

class Constants {
  static String baseUrl = !kIsWeb && Platform.isAndroid
      ? "http://10.0.2.2:4500/api/v1"
      : "http://localhost:4500/api/v1";
}
