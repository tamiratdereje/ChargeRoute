import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

class Constants {
  static String baseUrl = !kIsWeb && Platform.isAndroid
      ? "http://10.0.2.2:8080/api/v1/"
      : "http://localhost:8080/api/v1/";
}
