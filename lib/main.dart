import 'package:flutter/material.dart';

import 'config/injection_container.dart' as di;
import 'config/my_app.dart';

void main() async {
  runApp(const TargetLoginApp());

  di.init();
}
