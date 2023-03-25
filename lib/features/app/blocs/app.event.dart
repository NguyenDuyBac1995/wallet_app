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

class LoadingPercentChanged extends AppEvent {
  final double loadingPercent;
  const LoadingPercentChanged(this.loadingPercent);
  @override
  List<Object> get props => [
        {loadingPercent}
      ];
}

class LanguageChanged extends AppEvent {
  final Locale locale;
  const LanguageChanged(this.locale);
  @override
  List<Object> get props => [
        {locale}
      ];
}

class TimeFormatChanged extends AppEvent {
  final String valueDate;
  const TimeFormatChanged(this.valueDate);
  @override
  List<Object> get props => [
        {valueDate}
      ];
}
