part of 'catalog_bloc.dart';

class CatalogState extends Equatable {
  const CatalogState({
    this.status = ViewStatus.initial,
    this.areas = const [],
    this.lawyers = const [],
    this.query = '',
    this.selectedAreaId,
    this.error,
  });

  final ViewStatus status;
  final List<LawArea> areas;
  final List<Lawyer> lawyers;
  final String query;
  final String? selectedAreaId;
  final String? error;

  /// Onlayn advokatlar soni (dizayndagi "12 ta faol" belgisi uchun).
  int get onlineCount => lawyers.where((l) => l.isOnline).length;

  CatalogState copyWith({
    ViewStatus? status,
    List<LawArea>? areas,
    List<Lawyer>? lawyers,
    String? query,
    String? selectedAreaId,
    bool clearArea = false,
    String? error,
  }) {
    return CatalogState(
      status: status ?? this.status,
      areas: areas ?? this.areas,
      lawyers: lawyers ?? this.lawyers,
      query: query ?? this.query,
      selectedAreaId: clearArea ? null : (selectedAreaId ?? this.selectedAreaId),
      error: error,
    );
  }

  @override
  List<Object?> get props => [
        status,
        areas,
        lawyers,
        query,
        selectedAreaId,
        error,
      ];
}
