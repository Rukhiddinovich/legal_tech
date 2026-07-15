import 'package:equatable/equatable.dart';

/// Boj hisobining bir qatori (label → qiymat).
class FeeLine extends Equatable {
  const FeeLine(this.label, this.value);

  final String label;
  final String value;

  @override
  List<Object?> get props => [label, value];
}

/// Boj hisoblash natijasi.
class FeeResult extends Equatable {
  const FeeResult({
    required this.total,
    required this.lines,
    required this.needsNotary,
  });

  /// Umumiy to'lanadigan boj (so'm).
  final int total;
  final List<FeeLine> lines;
  final bool needsNotary;

  @override
  List<Object?> get props => [total, lines, needsNotary];
}
