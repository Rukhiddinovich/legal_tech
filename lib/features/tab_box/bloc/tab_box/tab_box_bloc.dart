import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:legal_tech/core/network/form_status.dart';

part 'tab_box_event.dart';

part 'tab_box_state.dart';

class TabBoxBloc extends Bloc<TabBoxEvent, TabBoxState> {
  TabBoxBloc() : super(TabBoxState()) {
    on<TabBoxChangeIndexEvent>((event, emit) {
      emit(state.copyWith(selectedIndex: event.selectedIndex));
    });
  }
}
