import 'package:flutter/material.dart';
import 'config/my_app.dart';
import 'config/injection_container.dart' as di;

void main() {
  runApp(const TargetLoginApp());

  di.init();
}
