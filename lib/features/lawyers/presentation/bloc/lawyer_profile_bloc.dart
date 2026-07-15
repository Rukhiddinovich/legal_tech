import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/constants/view_status.dart';
import '../../domain/entities/review.dart';
import '../../domain/usecases/get_lawyer_reviews.dart';

part 'lawyer_profile_event.dart';
part 'lawyer_profile_state.dart';

/// Advokat profilidagi sharhlarni yuklovchi Bloc.
///
/// Advokatning o'zi route argument sifatida keladi, shu sababli Bloc
/// faqat sharhlar uchun javob beradi (SRP).
class LawyerProfileBloc extends Bloc<LawyerProfileEvent, LawyerProfileState> {
  LawyerProfileBloc(this._getReviews) : super(const LawyerProfileState()) {
    on<LawyerReviewsRequested>(_onReviewsRequested);
  }

  final GetLawyerReviews _getReviews;

  Future<void> _onReviewsRequested(
    LawyerReviewsRequested event,
    Emitter<LawyerProfileState> emit,
  ) async {
    emit(state.copyWith(status: ViewStatus.loading));
    final result = await _getReviews(event.lawyerId);
    result.fold(
      (failure) => emit(
        state.copyWith(status: ViewStatus.failure, error: failure.message),
      ),
      (reviews) => emit(
        state.copyWith(status: ViewStatus.success, reviews: reviews),
      ),
    );
  }
}
