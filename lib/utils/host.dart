import 'package:flutter/foundation.dart' show kIsWeb;

class port {
  static String portnumber = kIsWeb ? '127.0.0.1' : '10.0.2.2';
}
