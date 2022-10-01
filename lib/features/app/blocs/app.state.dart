part of 'app.bloc.dart';

class AppState extends Equatable {
  final List<Configuration> configurations;
  final double loadingPercent;

  const AppState(
      {this.configurations = const <Configuration>[], this.loadingPercent = 0});

  AppState copyWith(
      {List<Configuration> configurations = const <Configuration>[],
      double loadingPercent = 0}) {
    return AppState(
        configurations:
            configurations.isEmpty ? this.configurations : configurations,
        loadingPercent: loadingPercent = loadingPercent);
  }

  @override
  List<Object?> get props => [configurations, loadingPercent];
}
