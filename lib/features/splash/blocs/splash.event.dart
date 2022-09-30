part of 'splash.bloc.dart';

abstract class SplashEvent extends Equatable {
  const SplashEvent();

  @override
  List<Object> get props => [];
}

class LoadConfigurationEvent extends SplashEvent {}
