import 'package:legal_tech/features/theme/data/datasources/theme_local_datasources.dart';
import 'package:legal_tech/features/theme/data/repositories/theme_repository_impl.dart';
import 'package:legal_tech/features/theme/domain/repositories/theme_repository.dart';
import 'package:legal_tech/features/theme/domain/usecases/get_theme_usecase.dart';
import 'package:legal_tech/features/theme/domain/usecases/set_theme_usecase.dart';
import 'package:legal_tech/features/theme/presentation/bloc/theme/theme_bloc.dart';

import '../injection_container.dart';

Future<void> initThemeFeature() async {
  // BLoC
  sl.registerFactory(
    () => ThemeBloc(getThemeUseCase: sl(), setThemeUseCase: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetThemeUseCase(sl()));
  sl.registerLazySingleton(() => SetThemeUseCase(sl()));

  // Repository
  sl.registerLazySingleton<ThemeRepository>(
    () => ThemeRepositoryImpl(localDataSource: sl()),
  );

  // Data Source
  sl.registerLazySingleton<ThemeLocalDataSource>(
    () => ThemeLocalDataSourceImpl(themeHiveService: sl()),
  );
}
