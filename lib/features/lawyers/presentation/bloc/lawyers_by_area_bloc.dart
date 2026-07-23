import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/view_status.dart';
import '../../domain/entities/lawyer.dart';
import '../../domain/usecases/search_lawyers.dart';

part 'lawyers_by_area_event.dart';
part 'lawyers_by_area_state.dart';

class LawyersByAreaBloc extends Bloc<LawyersByAreaEvent, LawyersByAreaState> {
  LawyersByAreaBloc({
    required SearchLawyers searchLawyers,
  })  : _searchLawyers = searchLawyers,
        super(const LawyersByAreaState()) {
    on<LawyersByAreaStarted>(_onStarted);
  }

  final SearchLawyers _searchLawyers;

  Future<void> _onStarted(
    LawyersByAreaStarted event,
    Emitter<LawyersByAreaState> emit,
  ) async {
    emit(state.copyWith(status: ViewStatus.loading));

    final result = await _searchLawyers(
      SearchLawyersParams(areaId: event.areaId),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(status: ViewStatus.failure, error: failure.message),
      ),
      (lawyers) => emit(
        state.copyWith(status: ViewStatus.success, lawyers: lawyers),
      ),
    );
  }
}
