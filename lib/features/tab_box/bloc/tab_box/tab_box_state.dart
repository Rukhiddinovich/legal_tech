part of 'tab_box_bloc.dart';

class TabBoxState {
  FormStatus? status;
  String? message;
  int selectedIndex;

  TabBoxState({this.status, this.message, this.selectedIndex = 0});

  TabBoxState copyWith({
    FormStatus? status,
    String? message,
    int? selectedIndex,
  }) {
    return TabBoxState(
      status: status ?? this.status,
      message: message ?? this.message,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
