part of 'splash.bloc.dart';

class SplashState extends Equatable {
  final double loadingPercent;

  const SplashState({this.loadingPercent = 0});

  SplashState copy({required double loadingPercent}) {
    return SplashState(
      loadingPercent: loadingPercent,
    );
  }

  @override
  List<Object?> get props => [loadingPercent];
}
