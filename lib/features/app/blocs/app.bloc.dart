import 'package:big_wallet/features/splash/repositories/configuration.repository.dart';
import 'package:big_wallet/models/configuration.model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

part 'app.event.dart';
part 'app.state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  final ConfigurationRepository configurationRepository;
  AppBloc(
    this.configurationRepository,
  ) : super(const AppState()) {
    on<LoadConfiguration>(onLoadConfiguration);
    on<ChangeLoadingPercent>(onChangeLoadingPercent);
  }

  void onLoadConfiguration(
      LoadConfiguration event, Emitter<AppState> emit) async {
    emit(state.copyWith(loadingPercent: 0.1));
    List<Configuration> configurations =
        await configurationRepository.getConfigurationsAsync();
    Logger().i(configurations);
    emit(state.copyWith(configurations: configurations));
  }

  void onChangeLoadingPercent(
      ChangeLoadingPercent event, Emitter<AppState> emit) {
    emit(state.copyWith(loadingPercent: event.loadingPercent));
  }
}
