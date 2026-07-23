part of 'catalog_bloc.dart';

sealed class CatalogEvent extends Equatable {
  const CatalogEvent();

  @override
  List<Object?> get props => [];
}

/// Sahifa ochilganda ma'lumotlarni yuklaydi.
class CatalogStarted extends CatalogEvent {
  const CatalogStarted();
}

/// Qidiruv matni o'zgardi.
class CatalogSearchChanged extends CatalogEvent {
  const CatalogSearchChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}
