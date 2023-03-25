import 'package:big_wallet/features/splash/repositories/configuration.repository.dart';
import 'package:big_wallet/models/configuration.model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app.event.dart';
part 'app.state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final ConfigurationRepository configurationRepository;
  AppBloc(
    this.configurationRepository,
  ) : super(const AppState()) {
    on<LoadConfiguration>(onLoadConfiguration);
    on<LoadingPercentChanged>(onChangeLoadingPercent);
    on<LanguageChanged>(onChangeLanguage);
    on<TimeFormatChanged>(onChangeTime);
  }

  void onLoadConfiguration(
      LoadConfiguration event, Emitter<AppState> emit) async {
    List<Configuration> configurations =
        await configurationRepository.getConfigurationsAsync(event.context);
    emit(state.copyWith(configurations: configurations));
    emit(state.copyWith(loadingPercent: 0.2));
  }

  void onChangeLoadingPercent(
      LoadingPercentChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(loadingPercent: event.loadingPercent));
  }

  void onChangeLanguage(LanguageChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(locale: event.locale));
  }

  void onChangeTime(TimeFormatChanged event, Emitter<AppState> emit) {
    emit(state.copyWith(valueDate: event.valueDate));
  }
}
