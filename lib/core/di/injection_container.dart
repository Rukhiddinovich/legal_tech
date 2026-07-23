import 'package:get_it/get_it.dart';

// Catalog
import '../../features/catalog/presentation/bloc/catalog_bloc.dart';
// Calculator
import '../../features/calculator/domain/usecases/calculate_fee.dart';
import '../../features/calculator/presentation/bloc/fee_calculator_bloc.dart';
// Consultation
import '../../features/consultation/data/datasources/consultation_mock_datasource.dart';
import '../../features/consultation/data/repositories/consultation_repository_impl.dart';
import '../../features/consultation/domain/repositories/consultation_repository.dart';
import '../../features/consultation/presentation/bloc/consultation_bloc.dart';
// Documents
import '../../features/documents/data/datasources/document_mock_datasource.dart';
import '../../features/documents/data/repositories/document_repository_impl.dart';
import '../../features/documents/domain/repositories/document_repository.dart';
import '../../features/documents/presentation/bloc/document_generator_bloc.dart';
// Law areas
import '../../features/law_areas/data/datasources/law_area_mock_datasource.dart';
import '../../features/law_areas/data/repositories/law_area_repository_impl.dart';
import '../../features/law_areas/domain/repositories/law_area_repository.dart';
// Lawyers
import '../../features/lawyers/data/datasources/lawyer_mock_datasource.dart';
import '../../features/lawyers/data/repositories/lawyer_repository_impl.dart';
import '../../features/lawyers/domain/repositories/lawyer_repository.dart';
import '../../features/lawyers/domain/usecases/get_lawyer_reviews.dart';
import '../../features/lawyers/domain/usecases/get_lawyers.dart';
import '../../features/lawyers/domain/usecases/search_lawyers.dart';
import '../../features/lawyers/presentation/bloc/lawyer_profile_bloc.dart';
import '../../features/lawyers/presentation/bloc/lawyers_by_area_bloc.dart';
import '../../features/lawyers/presentation/bloc/saved_lawyers_bloc.dart';
// Theme
import '../../features/theme/data/repositories/theme_repository_impl.dart';
import '../../features/theme/domain/repositories/theme_repository.dart';
import '../../features/theme/presentation/bloc/theme_bloc.dart';
// Wallet
import '../../features/wallet/data/repositories/wallet_repository_impl.dart';
import '../../features/wallet/domain/repositories/wallet_repository.dart';

/// Global Service Locator (get_it).
final GetIt sl = GetIt.instance;

/// Barcha bog'liqliklarni ro'yxatdan o'tkazadi.
///
/// Tartib: DataSource → Repository → UseCase → Bloc/Cubit.
/// Bloc/Cubit'lar `registerFactory` bilan (har safar yangi instansiya),
/// qolgan qatlamlar `registerLazySingleton` bilan ro'yxatdan o'tadi.
Future<void> initDependencies() async {
  _initTheme();
  _initLawyers();
  _initLawAreas();
  _initCatalog();
  _initConsultation();
  _initDocuments();
  _initCalculator();
  _initWallet();
}

void _initTheme() {
  sl.registerLazySingleton<ThemeRepository>(() => ThemeRepositoryImpl());
  sl.registerFactory<ThemeBloc>(() => ThemeBloc(sl()));
}

void _initLawyers() {
  sl.registerLazySingleton<LawyerDataSource>(() => LawyerMockDataSource());
  sl.registerLazySingleton<LawyerRepository>(
    () => LawyerRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetLawyers(sl()));
  sl.registerLazySingleton(() => SearchLawyers(sl()));
  sl.registerLazySingleton(() => GetLawyerReviews(sl()));
  sl.registerFactory<LawyerProfileBloc>(() => LawyerProfileBloc(sl()));
  sl.registerFactory<LawyersByAreaBloc>(() => LawyersByAreaBloc(searchLawyers: sl()));
  sl.registerLazySingleton<SavedLawyersBloc>(() => SavedLawyersBloc());
}

void _initLawAreas() {
  sl.registerLazySingleton<LawAreaDataSource>(() => LawAreaMockDataSource());
  sl.registerLazySingleton<LawAreaRepository>(
    () => LawAreaRepositoryImpl(sl()),
  );
}

void _initCatalog() {
  sl.registerFactory<CatalogBloc>(
    () => CatalogBloc(lawAreaRepository: sl(), searchLawyers: sl()),
  );
}

void _initConsultation() {
  sl.registerLazySingleton<ConsultationDataSource>(
    () => ConsultationMockDataSource(),
  );
  sl.registerLazySingleton<ConsultationRepository>(
    () => ConsultationRepositoryImpl(sl()),
  );
  sl.registerFactory<ConsultationBloc>(() => ConsultationBloc(sl()));
}

void _initDocuments() {
  sl.registerLazySingleton<DocumentDataSource>(() => DocumentMockDataSource());
  sl.registerLazySingleton<DocumentRepository>(
    () => DocumentRepositoryImpl(sl()),
  );
  sl.registerFactory<DocumentGeneratorBloc>(
    () => DocumentGeneratorBloc(sl()),
  );
}

void _initCalculator() {
  sl.registerLazySingleton(() => const CalculateFee());
  sl.registerFactory<FeeCalculatorBloc>(() => FeeCalculatorBloc(sl()));
}

void _initWallet() {
  sl.registerLazySingleton<WalletRepository>(() => WalletRepositoryImpl());
}
