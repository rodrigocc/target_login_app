import 'package:get_it/get_it.dart';
import 'package:target_sistemas/config/shared_preferences_injection.dart';

final serviceLocator = GetIt.I;

Future<void> init() async {
  await initSharedPref();
}
