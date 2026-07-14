import 'package:equatable/equatable.dart';
import 'package:legal_tech/core/domain/entities/meta.dart';

class BaseResponse<T> extends Equatable {
  final List<T> data;
  final MetaEntity meta;

  const BaseResponse({required this.data, required this.meta});

  @override
  List<Object?> get props => [data, meta];
}
