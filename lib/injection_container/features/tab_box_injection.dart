import 'package:legal_tech/features/tab_box/bloc/tab_box/tab_box_bloc.dart';
import '../injection_container.dart';

Future<void> initTabBoxFeature() async {
  // BLoC
  sl.registerFactory(() => TabBoxBloc());
}
