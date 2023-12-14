import 'package:shared_preferences/shared_preferences.dart';
import 'package:target_sistemas/config/injection_container.dart';

Future<void> initSharedPref() async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  serviceLocator.registerSingleton<SharedPreferences>(sharedPref);
}
