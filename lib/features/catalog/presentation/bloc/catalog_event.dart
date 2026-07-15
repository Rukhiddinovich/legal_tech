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

/// Huquq sohasi tanlandi (yoki bekor qilindi).
class CatalogAreaSelected extends CatalogEvent {
  const CatalogAreaSelected(this.areaId);

  final String areaId;

  @override
  List<Object?> get props => [areaId];
}
