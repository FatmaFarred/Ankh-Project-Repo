import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<Locale> {
  LanguageCubit() : super(const Locale('ar')); // Default language

  void changeLanguage(Locale newLocale) {
    if (state != newLocale) {
      emit(newLocale);
    }
  }
}