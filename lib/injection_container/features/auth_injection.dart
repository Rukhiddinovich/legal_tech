import 'package:legal_tech/features/auth/presentation/bloc/auth/auth_bloc.dart';

import '../injection_container.dart';

Future<void> initAuthFeature() async {
  // BLoC
  sl.registerFactory(() => AuthBloc());
}
