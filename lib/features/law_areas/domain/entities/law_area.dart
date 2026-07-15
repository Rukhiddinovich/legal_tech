import 'package:equatable/equatable.dart';

/// Huquq sohasi (Meros, Oila, Soliqlar, Jinoyat, ...).
///
/// [abbrev] — dizayndagi kvadrat ikonadagi qisqartma (M, O, S, J, Me, Ko).
class LawArea extends Equatable {
  const LawArea({
    required this.id,
    required this.name,
    required this.abbrev,
  });

  final String id;
  final String name;
  final String abbrev;

  @override
  List<Object?> get props => [id];
}
