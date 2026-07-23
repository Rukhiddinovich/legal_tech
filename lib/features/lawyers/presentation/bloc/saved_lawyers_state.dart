part of 'saved_lawyers_bloc.dart';

class SavedLawyersState extends Equatable {
  const SavedLawyersState({
    this.savedLawyers = const [],
  });

  final List<Lawyer> savedLawyers;

  bool isSaved(String lawyerId) {
    return savedLawyers.any((l) => l.id == lawyerId);
  }

  SavedLawyersState copyWith({
    List<Lawyer>? savedLawyers,
  }) {
    return SavedLawyersState(
      savedLawyers: savedLawyers ?? this.savedLawyers,
    );
  }

  @override
  List<Object> get props => [savedLawyers];
}
