// ignore_for_file: prefer_initializing_formals
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/view_status.dart';
import '../../../law_areas/domain/entities/law_area.dart';
import '../../../law_areas/domain/repositories/law_area_repository.dart';
import '../../../lawyers/domain/entities/lawyer.dart';
import '../../../lawyers/domain/usecases/search_lawyers.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

/// Katalog (Bosh sahifa) biznes-logikasi:
/// huquq sohalari + advokatlar ro'yxati + qidiruv/filtr.
class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc({
    required LawAreaRepository lawAreaRepository,
    required SearchLawyers searchLawyers,
  })  : _lawAreaRepository = lawAreaRepository,
        _searchLawyers = searchLawyers,
        super(const CatalogState()) {
    on<CatalogStarted>(_onStarted);
    on<CatalogSearchChanged>(_onSearchChanged);
  }

  final LawAreaRepository _lawAreaRepository;
  final SearchLawyers _searchLawyers;

  Future<void> _onStarted(
    CatalogStarted event,
    Emitter<CatalogState> emit,
  ) async {
    emit(state.copyWith(status: ViewStatus.loading));

    final areasResult = await _lawAreaRepository.getAreas();
    final areas = areasResult.getOrElse(() => const []);

    await _runSearch(emit, areas: areas);
  }

  Future<void> _onSearchChanged(
    CatalogSearchChanged event,
    Emitter<CatalogState> emit,
  ) async {
    emit(state.copyWith(query: event.query));
    await _runSearch(emit);
  }


  Future<void> _runSearch(
    Emitter<CatalogState> emit, {
    List<LawArea>? areas,
  }) async {
    final result = await _searchLawyers(
      SearchLawyersParams(query: state.query),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(status: ViewStatus.failure, error: failure.message),
      ),
      (lawyers) => emit(
        state.copyWith(
          status: ViewStatus.success,
          lawyers: lawyers,
          areas: areas ?? state.areas,
        ),
      ),
    );
  }
}
