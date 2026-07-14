import 'package:get_it/get_it.dart';
import 'core_injection.dart';
import 'features/auth_injection.dart';
import 'features/theme_injection.dart';
import 'features/tab_box_injection.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  /// Core dependencies
  await initCore();

  /// Feature dependencies
  await initThemeFeature();
  await initAuthFeature();
  await initTabBoxFeature();
}
