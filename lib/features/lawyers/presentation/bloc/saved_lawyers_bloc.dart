import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/lawyer.dart';

part 'saved_lawyers_event.dart';
part 'saved_lawyers_state.dart';

class SavedLawyersBloc extends Bloc<SavedLawyersEvent, SavedLawyersState> {
  SavedLawyersBloc() : super(const SavedLawyersState()) {
    on<LoadSavedLawyers>(_onLoadSavedLawyers);
    on<ToggleSavedLawyer>(_onToggleSavedLawyer);
    add(LoadSavedLawyers());
  }

  void _onLoadSavedLawyers(LoadSavedLawyers event, Emitter<SavedLawyersState> emit) {
    final box = Hive.box('saved_lawyers');
    final List<dynamic>? rawList = box.get('lawyers_list');
    
    if (rawList != null) {
      final List<Lawyer> loadedLawyers = rawList.map((e) {
        final Map<String, dynamic> map = Map<String, dynamic>.from(e as Map);
        return Lawyer.fromMap(map);
      }).toList();
      emit(state.copyWith(savedLawyers: loadedLawyers));
    }
  }

  void _onToggleSavedLawyer(ToggleSavedLawyer event, Emitter<SavedLawyersState> emit) {
    final currentSaved = List<Lawyer>.from(state.savedLawyers);
    final index = currentSaved.indexWhere((l) => l.id == event.lawyer.id);

    if (index >= 0) {
      currentSaved.removeAt(index);
    } else {
      currentSaved.add(event.lawyer);
    }

    emit(state.copyWith(savedLawyers: currentSaved));

    final box = Hive.box('saved_lawyers');
    final serializedList = currentSaved.map((l) => l.toMap()).toList();
    box.put('lawyers_list', serializedList);
  }
}
