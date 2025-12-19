import 'package:clean_architecture/features/presentation/blocks/theme_event.dart';
import 'package:clean_architecture/features/presentation/blocks/theme_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ThemeBlock extends Bloc<ThemeEvent, ThemeState> {
  ThemeBlock() : super(ThemeState(false)) {
    on<ChangeTheme>((event, emit) {
      emit(ThemeState(!state.isDark));
    });
  }
}
