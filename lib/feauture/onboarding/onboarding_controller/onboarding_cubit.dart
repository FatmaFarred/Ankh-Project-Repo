// features/on_boarding/onboarding_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class OnBoardingCubit extends Cubit<int> {
  OnBoardingCubit() : super(0);

  final PageController pageController = PageController();

  void updatePageIndicator(int index) => emit(index);

  void dotNavigationClick(int index) {
    emit(index);
    pageController.jumpToPage(index);
  }

  void nextPage() {
    if (state == 3) {
    } else {
      final nextPage = state + 1;
      pageController.jumpToPage(nextPage);
    }
  }

  void skipPage() {
    emit(3);
    pageController.jumpToPage(3);

  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}