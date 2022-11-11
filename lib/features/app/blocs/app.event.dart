part of 'app.bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();
  @override
  List<Object> get props => [];
}

class LoadConfiguration extends AppEvent {
  final BuildContext context;
  final List<Configuration> configurations;
  const LoadConfiguration(this.context, this.configurations);
  @override
  List<Object> get props => [
        {configurations}
      ];
}

class ChangeLoadingPercent extends AppEvent {
  final double loadingPercent;
  const ChangeLoadingPercent(this.loadingPercent);
  @override
  List<Object> get props => [
        {loadingPercent}
      ];
}

class ChangeLanguage extends AppEvent {
  final Locale locale;
  const ChangeLanguage(this.locale);
  @override
  List<Object> get props => [
        {locale}
      ];
}
