part of 'my_bloc_providers_part.dart';

class MyBlocProviders {
  static get providers {
    return [
      BlocProvider<ThemeBloc>(
        create: (context) => sl<ThemeBloc>()..add(GetThemeEvent()),
      ),
      BlocProvider<AuthBloc>(create: (context) => sl<AuthBloc>()),
    ];
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    debugPrint('🎯 BLoC Created: ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    debugPrint('🔄 BLoC Changed: ${bloc.runtimeType}');
    debugPrint('🔄 Current State: ${change.currentState}');
    debugPrint('🔄 Next State: ${change.nextState}');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    debugPrint('🚀 BLoC Transition: ${bloc.runtimeType}');
    debugPrint('🚀 Event: ${transition.event}');
    debugPrint('🚀 Current State: ${transition.currentState}');
    debugPrint('🚀 Next State: ${transition.nextState}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    debugPrint('📝 BLoC Event: ${bloc.runtimeType} - $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debugPrint('❌ BLoC Error: ${bloc.runtimeType}');
    debugPrint('❌ Error: $error');
    debugPrint('❌ StackTrace: $stackTrace');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    debugPrint('🔒 BLoC Closed: ${bloc.runtimeType}');
  }
}
