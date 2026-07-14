import 'package:equatable/equatable.dart';

class MetaEntity extends Equatable {
  final int totalCount;
  final int pageCount;
  final int currentPage;
  final int perPage;
  final int from;
  final int to;

  const MetaEntity({
    required this.totalCount,
    required this.pageCount,
    required this.currentPage,
    required this.perPage,
    required this.from,
    required this.to,
  });

  bool get hasNextPage => currentPage < pageCount;

  bool get hasPreviousPage => currentPage > 1;

  int get nextPage => currentPage + 1;

  int get previousPage => currentPage - 1;

  bool get isFirstPage => currentPage == 1;

  bool get isLastPage => currentPage == pageCount;

  int get totalPages => pageCount;

  int get firstItemIndex => from;

  int get lastItemIndex => to;

  factory MetaEntity.empty() => const MetaEntity(
    totalCount: 0,
    pageCount: 0,
    currentPage: 0,
    perPage: 0,
    from: 0,
    to: 0,
  );

  @override
  List<Object?> get props => [
    totalCount,
    pageCount,
    currentPage,
    perPage,
    from,
    to,
  ];
}

class MetaModel extends MetaEntity {
  const MetaModel({
    required super.totalCount,
    required super.pageCount,
    required super.currentPage,
    required super.perPage,
    required super.from,
    required super.to,
  });

  factory MetaModel.fromJson(Map<String, dynamic> json) {
    return MetaModel(
      totalCount: json['total'] as int? ?? 0,
      pageCount:
          json['last_page'] as int? ??
          (json['total'] != null && json['limit'] != null
              ? (json['total'] as int) ~/ (json['limit'] as int) +
                    ((json['total'] as int) % (json['limit'] as int) == 0
                        ? 0
                        : 1)
              : 0),
      currentPage: json['current_page'] as int? ?? json['page'] as int? ?? 0,
      perPage: json['per_page'] as int? ?? json['limit'] as int? ?? 0,
      from: json['from'] as int? ?? 0,
      to: json['to'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'total': totalCount,
      'last_page': pageCount,
      'current_page': currentPage,
      'per_page': perPage,
      'from': from,
      'to': to,
    };
  }

  factory MetaModel.empty() => const MetaModel(
    totalCount: 0,
    pageCount: 0,
    currentPage: 0,
    perPage: 0,
    from: 0,
    to: 0,
  );
}
