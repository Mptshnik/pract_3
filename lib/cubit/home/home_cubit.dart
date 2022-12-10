import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../theme/theme_cubit.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  int clickCount = 0;
  List<String> messages = [];
  String message = '';

  void handleClick(ThemeMode themeMode) {
    if (themeMode == ThemeMode.dark) {
      clickCount += 2;
      emit(ClickState(clickCount));
    } else {
      clickCount++;
      emit(ClickState(clickCount));
    }
/*
    if (clickCount >= 100) {
      emit(FinishState());
    }*/

    message = "Кликер: $clickCount. Тема: ${themeMode.name}";

    messages.add(message);
  }

  void handleClickMinus(ThemeMode themeMode) {
    if (themeMode == ThemeMode.dark) {
      clickCount -= 2;
    } else {
      clickCount--;
    }

    message = "Кликер: $clickCount. Тема: ${themeMode.name}";

    emit(ClickState(clickCount));

    messages.add(message);
  }

  void themeSwitched(BuildContext context) {
    messages.add(
        'Вы поменяли тему на ${context.read<ThemeCubit>().themeMode.name}');
  }
}
