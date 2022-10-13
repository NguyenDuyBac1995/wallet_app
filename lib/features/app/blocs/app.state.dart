part of 'app.bloc.dart';

class AppState extends Equatable {
  final List<Configuration> configurations;
  final double loadingPercent;
  final Locale locale;

  const AppState(
      {this.configurations = const <Configuration>[],
      this.loadingPercent = 0,
      this.locale = const Locale('en', '')});

  AppState copyWith(
      {List<Configuration> configurations = const <Configuration>[],
      double loadingPercent = 0,
      Locale locale = const Locale('en', '')}) {
    return AppState(
        configurations:
            configurations.isEmpty ? this.configurations : configurations,
        loadingPercent: loadingPercent == this.loadingPercent
            ? this.loadingPercent
            : loadingPercent,
        locale: locale.languageCode == this.locale.languageCode
            ? this.locale
            : locale);
  }

  @override
  List<Object?> get props => [configurations, loadingPercent, locale];
}
