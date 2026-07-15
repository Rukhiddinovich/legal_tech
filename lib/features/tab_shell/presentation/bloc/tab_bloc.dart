import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tab_event.dart';

/// Pastki navigatsiyadagi tanlangan tab indeksini boshqaradi.
class TabBloc extends Bloc<TabEvent, int> {
  TabBloc() : super(0) {
    on<TabSelected>((event, emit) => emit(event.index));
  }
}
