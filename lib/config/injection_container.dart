import 'package:get_it/get_it.dart';
import 'package:target_sistemas/config/shared_preferences_injection.dart';
import 'package:target_sistemas/features/login/presentation/controller/login_controller.dart';

final serviceLocator = GetIt.I;

Future<void> init() async {
  await initSharedPref();
  serviceLocator.registerSingleton<LoginController>(LoginController());
}
