part of 'splash.bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();
  final num percent = 0;
  @override
  List<Object> get props => [];
}

class SplashInitialState extends SplashState {}

class SplashLoadingState extends SplashState {}

class SplashLoadedState extends SplashState {}

class SplashErrorState extends SplashState {}
